import subprocess


active_wallpaper_process = subprocess.Popen(['hyprctl','hyprpaper','listactive'], stdout=subprocess.PIPE)


output,err = active_wallpaper_process.communicate()


path = output.decode().split('=')[1].strip()
generate_colorscheme_process = subprocess.Popen(['wallust',path], stdout=subprocess.PIPE)
print('Updated colorscheme for', path)
