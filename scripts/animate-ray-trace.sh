#!/bin/bash
# $1 is the directory with the frames
# $2 is the output mp4 name
ffmpeg -r 60 -f image2 -s 1000x1000 -i "$1/f-%10d.ppm" -vcodec libx264 -crf 15 -pix_fmt yuv420p "$2"

