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
