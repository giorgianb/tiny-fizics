#!/usr/bin/python3
import argparse
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.animation as animation
import mpl_toolkits.mplot3d.axes3d as p3
from itertools import islice

parser = argparse.ArgumentParser(
        description='Animate trajectories given by coordinates in files.'
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
parser.add_argument('--fps', 
        type=int,
        help='Set the frames per second in the animation. (default=60)')
parser.add_argument('--output',
        type=str,
        help='Set where to place the output. (default=ani.mp4)')
parser.add_argument('--nframes',
        metavar='NF',
        type=int,
        help='Animate NF frames total. (default is as many frames as possible)')
parser.add_argument('--interval',
        type=float,
        help='Number of milliseconds to wait in between frames (default=0.3)')

args = parser.parse_args()

SAMPLE_FACTOR = args.sample_factor if args.sample_factor else 100
OUTPUT = args.output if args.output else 'ani.mp4'
FPS = args.fps if args.fps else 60
NFRAMES = args.nframes # if none, animate as many frames as possible
INTERVAL = args.interval if args.interval else 0.3

# x coordinates
xs = []
ys = []
zs = []
# y coordinates
xv = []
yv = []
zv = []
for file_name in args.files:
    print("reading file {}...".format(file_name))
    xs.append([])
    ys.append([])
    zs.append([])
    xv.append([])
    yv.append([])
    zv.append([])
    with open(file_name, 'r') as f:
        for line in islice(f, 0, None, SAMPLE_FACTOR):
            d = tuple(map(float, line.split()))
            if len(d) >= 7:
                r, x, y, z, vx, vy, vz = d[:7]
                xs[-1].append(x)
                ys[-1].append(y)
                zs[-1].append(z)

                xv[-1].append(vx)
                yv[-1].append(vy)
                zv[-1].append(vz)
            elif len(d) >= 4:
                r, x, y, z = d[:4]
                xs[-1].append(x)
                ys[-1].append(y)
                zs[-1].append(z)

n = min(map(len, xs))
NFRAMES = min(n, NFRAMES) if NFRAMES else n

fig = plt.figure()
all_x = sum(xs, [])
all_y = sum(ys, [])
all_z = sum(zs, [])
x_min, x_max = min(all_x), max(all_x)
y_min, y_max = min(all_y), max(all_y)
z_min, z_max = min(all_z), max(all_z)
ax = p3.Axes3D(fig, xlim=(x_min, x_max), ylim=(y_min, y_max))
ax.set_xlim3d((x_min, x_max))
ax.set_ylim3d((y_min, y_max))
ax.set_zlim3d((z_min, z_max))
points = tuple(ax.plot(all_x, all_y,  all_z, 'o', ms=30)[0] for i in range(len(xs)))
lines = tuple(ax.plot(all_x, all_y, all_z, lw=2)[0] for i in range(len(xs)))

# Update to decrement last point draw if current velocity < old velocity
def line_begin(i, j):
#    v = int((xv[j][i]**2 + yv[j][i]**2)**(1.0/2) * 30)

    return max(0, i - 100)

# initialization function: plot the background of each frame
def init():
    for line, point in zip(lines, points):
        line.set_data([], [])
        line.set_3d_properties([])
        point.set_data([], [])
        point.set_3d_properties([])

    return tuple(points) + tuple(lines)

# animation function.  This is called sequentially
def animate(i):
    if i % 100 == 0:
        print("finished animating frame {}".format(i))

    f = lambda l: l[i]
    for j in range(len(xs)):
        points[j].set_data([xs[j][i]], [ys[j][i]])
        points[j].set_3d_properties([zs[j][i]])
        lines[j].set_data(xs[j][line_begin(i, j):i], ys[j][line_begin(i, j):i])
        lines[j].set_3d_properties(zs[j][line_begin(i, j):i])

    return tuple(points) + tuple(lines)

# Dump parameters before we start animating
print("FILES = {}".format(args.files))
print("SAMPLE_FACTOR = {}".format(SAMPLE_FACTOR))
print("OUTPUT = {}".format(OUTPUT))
print("FPS = {}".format(FPS))
print("NFRAMES = {}".format(NFRAMES))
print("INTERVAL = {}".format(INTERVAL))
print("x = [{}, {}]".format(x_min, x_min))
print("y = [{}, {}]".format(y_min, y_min))
print("z = [{}, {}]".format(z_min, z_min))


# call the animator.  blit=True means only re-draw the parts that have changed.
anim = animation.FuncAnimation(fig, animate, init_func=init,
                               frames=NFRAMES, interval=INTERVAL, blit=True)

# save the animation as an mp4.  This requires ffmpeg or mencoder to be
# installed.  The extra_args ensure that the x264 codec is used, so that
# the video can be embedded in html5.  You may need to adjust this for
# your system: for more information, see
# http://matplotlib.sourceforge.net/api/animation_api.html
anim.save(OUTPUT, fps=FPS, extra_args=['-vcodec', 'libx264'])
