program simulate
    use, intrinsic :: iso_fortran_env, only : error_unit
    use physics

    implicit none

    integer, parameter :: max_file_name_length = 4096

    integer :: nbodies, nsteps
    real(kind=pkind) :: dt

    type(particle), dimension(:), allocatable :: b
    type(particle), dimension(:, :), allocatable :: bt
    character(len=:), allocatable :: argument
    character(len=max_file_name_length) :: file_name
    integer :: arg_length

    integer :: i, j
    integer, parameter :: fin = 9
    integer, parameter :: fout = 10

    real(kind=pkind) :: m, r, q
    real(kind=pkind), dimension(d) :: x, v

    if (command_argument_count() /= 1) then
        call get_command_argument(0, length=arg_length)
        allocate(character(len=arg_length) :: argument)
        call get_command_argument(0, argument)
        write (error_unit, '(a, a, a)') "usage: ", argument, " FILE"
        deallocate(argument)
        stop 1
    end if

    call get_command_argument(1, length=arg_length)
    allocate(character(len=arg_length) :: argument)
    call get_command_argument(1, argument)
    open(unit=fin, file=argument, status='old')
    read (fin, *) dt, nsteps, nbodies
    allocate(b(nbodies))
    allocate(bt(nbodies, nsteps))
    do i = 1, nbodies
        read (fin, *) m, r, q, x, v
        b(i) = particle(m, r, q, x, v)
    end do
    close(fin)

    call step(b, bt, dt)
    do i = 1, nbodies
        write (file_name, '(a,i10.10,a)') "p-", i, ".dat"
        open(unit=fout, status='replace', file=file_name)
        do j = 1, nsteps
            write (fout, *) bt(i, j)%r, bt(i, j)%x, bt(i, j)%v
        end do
        close(fout)
    end do
    deallocate(b)
    deallocate(bt)

    stop 0
end program simulate
