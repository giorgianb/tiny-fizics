#!/bin/bash

RAY_TRACER="/home/giorgian/Proiecte/ray-tracer/rt"

for file in *.rt; do
    new_file=$(echo $file | sed 's/\.rt$/.ppm/g')
    echo "$file -> $new_file"
    $RAY_TRACER --file="$file" --out="$new_file" > /dev/null
done
