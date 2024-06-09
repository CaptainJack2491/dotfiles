import os
import glob
import subprocess

folder_path = '/home/jayrup/Pictures/wallpapers/'

def get_current_wallpaper() -> str:
    process = subprocess.Popen(['current_wal'], stdout=subprocess.PIPE)
    output,err = process.communicate()

    return output.decode().strip()

def get_next_wallpaper(current_wallpaper:str, files:list) -> str:
    for index,file in enumerate(files):
        if file == current_wallpaper:
            try:
                return files[index+1]
                break
            except:
                print('next file does not exist, restarting the loop')
                return files[0]
                break
    

current_wallpaper = get_current_wallpaper()

files = glob.glob(folder_path+'*')

next_wallpaper = get_next_wallpaper(current_wallpaper,files)

process = subprocess.Popen(['hyprctl','hyprpaper','unload', 'all'],stdout=subprocess.PIPE)
process.communicate()
