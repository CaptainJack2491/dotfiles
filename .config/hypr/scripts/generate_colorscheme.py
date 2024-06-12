#!/usr/bin/python3

import subprocess


output = subprocess.run(['hyprctl','hyprpaper','listactive'], stdout=subprocess.PIPE)


# output,err = active_wallpaper_process.communicate()


path = output.stdout.decode().split('=')[1].strip()
generate_colorscheme_process = subprocess.run(['wallust',path], stdout=subprocess.PIPE)
print('Updated colorscheme for', path)
