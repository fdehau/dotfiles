#!/bin/bash

xrandr_version=$(xrandr --version | head -n 1 | awk '{print $4}')
# Count the number of monitors
if [[ "$xrandr_version" == "1.4.1" ]]; then
  monitors="$(xrandr | grep " connected " | cut -d' ' -f1)"
else
  monitors="$(xrandr --listmonitors | grep Monitors | cut -d' ' -f2)"
fi
# Args to pass to feh
args=""
# Directory to look for the images
media_dir="$HOME/dotfiles/media"

i=0
while [[ $i -lt ${#monitors[@]} ]]; do
  args="$args --bg-scale $media_dir/bg0.jpg"
  (( i = i + 1))
done

feh $args
