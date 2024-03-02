
DIR=~/Pictures/wallpaper


# for file in "$DIR/"* ; do
#   # Check if it's a regular file (avoid hidden files, etc.)
#   if [ -f "$file" ]; then
#     # Process the file here
#     echo "$file"
#     # Your actual processing logic using the file variable
#   fi
# done
#
echo $(find "$DIR/" -maxdepth 1 -type f -print | head -n 1)

