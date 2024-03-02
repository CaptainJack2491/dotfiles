DIR=~/Pictures/wallpaper

# stdout a random wallpaper
find $DIR -type f | shuf -n 1
