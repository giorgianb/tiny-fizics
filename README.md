# tiny-fizics
Tiny fizics is a small, easy-to-use, physics engine that comes with some utilities for creating animations of the resulting simulations. It is written in modern Fortran and is meant to be simple and fast.

## Compiling
To compile the Physics Engine, only `gfortran` is required to be installed. On Ubuntu, this can be installed using `sudo apt install gfortran`. Some systems may come with `gfortran` already installed; in any case, refer to your system's documentation on how to install packages and `gfortran`.

Once gfortran is installed, building is simple.

```
$ git clone https://github.com/giorgianb/tiny-fizics
$ cd tiny-fizics
$ make
```

This will create a `simulate` executable in the `bin/` folder, which you can use to run simulations, and a `physics.mod` file in the `lib/` folder, which can be used in Fortran programs by specifying `use physics` at the beginning of the program and passing `lib/physics.mod` as an argument to the compiler when compiling.

If you want to animate your simulations, a few more packages need to be installed. To create quick and simple simulations using `matplotlib`, please install the `matplotlib` package for `python3`. If you want to create ray-traced animations, the `Materials` branch of `giorgianb/ray-tracer` must be compiled and installed. Instructions to do so are further down. The ray-traced animations also either require `gimp` or `ffmpeg`; on Ubuntu systems, these can be installed using `sudo apt install gimp` or `sudo apt install ffmpeg`.

### Installing `giorgianb/ray-tracer`

There's no proper installer for `giorgianb/ray-tracer`. Rather, it just produces a binary in the directory the code is downloaded in. That's enough for our purposes. 

```
$ git clone https://github.com/giorgianb/ray-tracer
$ cd ray-tracer
$ git checkout Materials
$ ./compile.sh
```

It's still in development, so a proper `Make` file hasn't been written for it yet, but the basic `compile.sh` works for now. This will produce a `rt` executable in the `ray-tracer` directory. Make sure you have `g++` installed; on Ubuntu systems, this can be installed with `sudo apt install g++`.

## Simulations
The `simulate` executable takes a file which specifies the parameters for the simulation. The parameters for the simulation are the following; the time step `dt`, the number of steps to simulate `nsteps`, the number of bodies to simulate `nbodies`, and the mass `m`, radius `r`, charge `q`, coordiantes `x y z` and velocity `vx vy vz` of each body. Thus, a generalized simulation file looks like this:
```
dt nsteps
nbodies
x_1 r_1 q_1 x_1 y_1 z_1 vx_1 vy_1 vz_1
x_2 r_2 q_2 x_2 y_2 z_2 vx_2 vy_2 vz_2
.
.
.
x_n r_n q_n x_n y_n z_n vx_n vy_n vz_n
```

Several example simulation files are provided in the `examples/` directory. Running a simulation requires running the `simulate` binary with the simulation file as the first argument.
```
$ bin/simulate examples/charged.fz
```

In this case, `examples/charged.fz` is the simulation file. This will produce a bunch of `.dat` files in the current directory, which specify the radius, positions and velocities of the body at each time step. The format of these files is `r x y z vx vy vz`, where `r` is the radius of the body, `x y z` is the position of the body, and `vx vy vz` is the velocity of the body. For a 3-body system, 3 files will be created: `p-0000000001.dat`, `p-0000000002.dat` and `p-0000000003.dat`. These files specify the radii, positions, and velocity of each body respectively. 
