#!/bin/sh

dunst &

feh --bg-fill /home/vk/Downloads/plane.jpg

picom --backend glx --vsync &

exec sowm
