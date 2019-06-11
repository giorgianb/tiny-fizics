all: physics simulate

physics: src/physics.f08
	gfortran -o lib/physics.mod -c -O2 -std=f2008 -Wall -Werror -pedantic-errors src/physics.f08

simulate: physics src/simulate.f08
	gfortran -o bin/simulate -O2 -std=f2008 -Wall -Werror -pedantic-errors src/simulate.f08 lib/physics.mod

clean:
	rm -f lib/* bin/* physics.mod
