import sys
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.animation as animation
from itertools import islice

#NFRAMES = 100
skip_factor = 100
xs = []
ys = []
zs = []
xv = []
yv = []
zv = []
for file_name in sys.argv[1:]:
    xs.append([])
    ys.append([])
    zs.append([])
#    xv.append([])
#    yv.append([])
#    zv.append([])
    with open(file_name, 'r') as f:
        for line in islice(f, 0, None, skip_factor):
            x, y, z, vx, vy, vz = map(float, line.split())
            xs[-1].append(x)
            ys[-1].append(y)
            zs[-1].append(z)
#            xv[-1].append(vx)
#            yv[-1].append(vy)
#            zv[-1].append(vz)


n = min(map(len, xs))

fig = plt.figure()
all_x = sum(xs, [])
all_y = sum(ys, [])
all_z = sum(zs, [])
x_min, x_max =min(all_x), max(all_x)
y_min, y_max = min(all_y), max(all_y)
z_min, z_max = min(all_z), max(all_z)
ax = plt.axes(xlim=(x_min, x_max), ylim=(y_min, y_max))
points = [ax.plot([], [], 'o', ms=6)[0] for i in range(len(xs))]
lines = [ax.plot([], [], lw=2)[0] for i in range(len(xs))]

# Update to decrement last point draw if current velocity < old velocity
def line_begin(i, j):
#    v = int((xv[j][i]**2 + yv[j][i]**2)**(1.0/2) * 30)

    return max(0, i - 100)

# initialization function: plot the background of each frame
def init():
#    points.set_data([], [])
#    for line in lines:
#        line.set_data([], [])

    for point in points:
        point.set_data([], [])

    return tuple(points) + tuple(lines)

# animation function.  This is called sequentially
def animate(i):
    if i % 100 == 0:
        print(i)

    f = lambda l: l[i]
    for j in range(len(xs)):
        points[j].set_data([xs[j][i]], [ys[j][i]])
#    for j in range(len(xs)):
#        lines[j].set_data(xs[j][line_begin(i, j):i], ys[j][line_begin(i, j):i])
    return tuple(points) + tuple(lines)

print("n={}".format(n))
# call the animator.  blit=True means only re-draw the parts that have changed.
anim = animation.FuncAnimation(fig, animate, init_func=init,
                               frames=n, interval=0.01, blit=True)

# save the animation as an mp4.  This requires ffmpeg or mencoder to be
# installed.  The extra_args ensure that the x264 codec is used, so that
# the video can be embedded in html5.  You may need to adjust this for
# your system: for more information, see
# http://matplotlib.sourceforge.net/api/animation_api.html
anim.save('basic_animation.mp4', fps=60, extra_args=['-vcodec', 'libx264'])
