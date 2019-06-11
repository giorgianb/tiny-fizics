#!/usr/bin/python3
import argparse
import matplotlib.pyplot as plt
import numpy as np
from itertools import islice
from random import uniform
import os

parser = argparse.ArgumentParser(
        description='Create ray tracer frames for trajectories given by coordinates in files.'
        )
parser.add_argument('files', 
        metavar='FILE', 
        type=str, 
        nargs='+', 
        help='A file with trajectory coordinates to animate.')
parser.add_argument('--sample-factor', 
        metavar='NS', 
        type=int,
        help='Use every NS-th coordinate as a frame for the animation. (default=100)')
parser.add_argument('--output',
        type=str,
        help='Set the directory where to store the frames. (default=ani)')
parser.add_argument('--nframes',
        metavar='NF',
        type=int,
        help='Animate NF frames total. (default is as many frames as possible)')
parser.add_argument('--interval',
        type=float,
        help='Number of milliseconds to wait in between frames (default=0.3)')

args = parser.parse_args()

SAMPLE_FACTOR = args.sample_factor if args.sample_factor else 100
OUTPUT = args.output if args.output else 'ani'
NFRAMES = args.nframes # if none, animate as many frames as possible

# coordinates
xs = []
# sppeds
vs = []

radii = []
colors = []
for file_name in args.files:
    print("reading file {}...".format(file_name))
    xs.append([])
    vs.append([])
    colors.append((uniform(0, 1), uniform(0, 1), uniform(0, 1)))
    with open(file_name, 'r') as f:
        for line in islice(f, 0, None, SAMPLE_FACTOR):
            d = tuple(map(float, line.split()))
            if len(d) >= 7:
                r, x, y, z, vx, vy, vz = d[:7]
                radii.append(r)
                xs[-1].append((x, y, z))
                vs[-1].append((x, y, z))
            elif len(d) >= 4:
                r, x, y, z = d[:4]
                radii.append(r)
                xs[-1].append((x, y, z))
                
n = min(map(len, xs))
NFRAMES = NFRAMES if NFRAMES else n

all_x = sum(xs, [])
x_min, x_max = min(map(lambda x: x[0], all_x)), max(map(lambda x: x[0], all_x))
y_min, y_max = min(map(lambda x: x[1], all_x)), max(map(lambda x: x[1], all_x))
z_min, z_max = min(map(lambda x: x[2], all_x)), max(map(lambda x: x[2], all_x))

# Dump parameters before we start animating
print("FILES = {}".format(args.files))
print("SAMPLE_FACTOR = {}".format(SAMPLE_FACTOR))
print("OUTPUT = {}".format(OUTPUT))
print("NFRAMES = {}".format(NFRAMES))

os.mkdir(OUTPUT)
os.chdir(OUTPUT)

for i in range(NFRAMES):
    file_name = "f-%010d.rt" % i
    if i % 100 == 0:
        print("finished creating frame {}...".format(i))

    with open(file_name, 'w') as f:
        print("PointLightSource\n0 0 -100  30000", file=f)
        print("""
CheckeredPlane
100 0 0	    0 0 100	0 -100 0
3
0 0 0 1 1 1 0
0 0 0 1 1 0 1
0 0 0 1 0 1 1""", file=f)
        for j, clist in enumerate(xs):
            x, y, z = clist[i]
            r, g, b = colors[j]
            print("Sphere\n{} {} {} {} 0 0 0 1 {} {} {}".format(x, y, z, radii[j], r, g, b), file=f)
