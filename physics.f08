module physics
    implicit none
    private

    integer, parameter :: pkind = 8
    real(kind=pkind), parameter :: G = 6.674e-11 ! Gravitational Constant
    real(kind=pkind), parameter :: k = 8.987551787368176e9 ! Electric Constant

    ! The number of dimensions in our universe
    integer, parameter :: d = 3

    type particle
        real(kind=pkind) :: m ! mass
        real(kind=pkind) :: r ! radius
        real(kind=pkind) :: q ! charge
        real(kind=pkind), dimension(d) :: x ! position
        real(kind=pkind), dimension(d) :: v ! velocity
    end type particle

    interface step
        module procedure single_step, all_steps
    end interface step

    public :: pkind
    public :: G
    public :: k
    public :: d
    public :: particle
    public :: step
contains
    pure subroutine collision(b1, b2, nb1, nb2)
        type(particle), intent(in) :: b1, b2
        type(particle), intent(out) :: nb1
        type(particle), intent(out), optional :: nb2
        
        nb1 = b1
        if (present(nb2)) nb2 = b2
        
        ! Through momentum and kinetic energy conservation
        nb1%v = ((b1%m - b2%m) * b1%v + 2*b2%m * b2%v)/(b1%m + b2%m)
        if (present(nb2)) nb2%v = ((b2%m - b1%m) * b2%v + 2*b1%m * b1%v)/(b1%m + b2%m)
    end subroutine collision

    pure subroutine collides(bi, b, collision, cb)
        type(particle), intent(in) :: bi
        type(particle), dimension(:), intent(in) :: b
        logical, intent(out) :: collision
        type(particle), intent(out), optional :: cb

        integer :: i
        real(kind=pkind), dimension(d) :: r

        collision = .false.
        do i = 1, size(b)
            r = b(i)%x - bi%x
            if (dot_product(r, r) <= (b(i)%r + bi%r)**2) then
                collision = .true.
                if (present(cb)) cb = b(i)
                exit
            end if
        end do
    end subroutine collides

    pure function force(b1, b2) result(f)
        implicit none

        type(particle), intent(in) :: b1, b2
        real(kind=pkind), dimension(d) :: f

        real(kind=pkind), dimension(d) :: r
        real(kind=pkind), dimension(d) :: r_hat

        r = b2%x - b1%x
        if (dot_product(r, r) == 0) then
            f = 0
        else
            r_hat = r  / sqrt(dot_product(r, r))
            f = ((G *b1%m * b2%m) + (k * b1%q * b2%q)) * r_hat / dot_product(r, r)
        end if
    end function force

    pure function total_force(bi, b) result(f)
        implicit none

        type(particle), intent(in) :: bi
        type(particle), dimension(:), intent(in) :: b
        real(kind=pkind), dimension(d) :: f

        integer :: i

        f = 0
        do i = 1, size(b)
            f = f + force(bi, b(i))
        end do
    end function total_force

    subroutine single_step(b, nb, dt)
        implicit none

        type(particle), dimension(:), intent(in) :: b
        type(particle), dimension(:), intent(out) :: nb
        real(kind=pkind), intent(in) :: dt

        integer :: i
        real(kind=pkind), dimension(d, size(b)) :: v_half
        type(particle) :: cb ! particle collided with, if any
        type(particle) :: cnb ! new particle parameteres after collision, if any

        logical :: has_collision

        nb = b
        do i = 1, size(b)
            call collides(b(i), b(:i-1), has_collision, cb)
            if (.not. has_collision) call collides(b(i), b(i+1:), has_collision, cb)
            if (has_collision) then
                call collision(b(i), cb, cnb)
                v_half(:, i) = cnb%v + total_force(b(i), b)/b(i)%m * dt * 0.5
                nb(i)%x = b(i)%x + v_half(:, i) * dt
                nb(i)%v = v_half(:, i) +  &
                    (total_force(nb(i), b(:i-1)) + total_force(nb(i), b(i+1:)))/b(i)%m * dt
            else
                v_half(:, i) = b(i)%v + total_force(b(i), b)/b(i)%m * dt * 0.5
                nb(i)%x = b(i)%x + v_half(:, i) * dt
                nb(i)%v = v_half(:, i) +  &
                    (total_force(nb(i), b(:i-1)) + total_force(nb(i), b(i+1:)))/b(i)%m * dt
            end if
        end do
    end subroutine single_step

    subroutine all_steps(b, bt, dt)
        implicit none

        type(particle), dimension(:), intent(in) :: b
        type(particle), dimension(:, :), intent(out) :: bt
        real(kind=pkind), intent(in) :: dt

        integer :: i

        bt(:, 1) = b
        do i = 2, size(bt, 2)
            call single_step(bt(:, i - 1), bt(:, i), dt)
        end do
    end subroutine all_steps
end module physics
