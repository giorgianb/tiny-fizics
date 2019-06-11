#!/bin/bash

for file in $@; do
    new_file=$(echo $file | sed 's/\.rt$/.ppm/g')
    echo "$file -> $new_file"
    rt --file="$file" --out="$new_file" > /dev/null
done
