import os
import subprocess

wallpaper_dir = "/home/jayrup/Pictures/wallpapers/"
wallpaper_files = os.listdir(wallpaper_dir)

def get_next_wallpaper(current_wallpaper:str, files:list[str]) -> str:
    for index,file in enumerate(files):
        if wallpaper_dir+file == current_wallpaper:
            try:
                return files[index+1]
            except IndexError:
                pass
        # print('next file does not exist, restarting the loop')
    return files[0]
    
def change_wallpaper(wallpaper_path:str) -> None:
    print("changing wallpaper")
    subprocess.run(["hyprctl", "hyprpaper", "unload", "all"])
    subprocess.run(["hyprctl", "hyprpaper", "preload", wallpaper_path])
    subprocess.run(["hyprctl", "hyprpaper", "wallpaper", ",", wallpaper_path])


def generate_colorscheme(wallpaper) -> None:
    subprocess.run(["wal", "-i", wallpaper, "-n"])

active_wal = subprocess.run(["hyprctl", "hyprpaper", "listactive"], capture_output=True, text=True)
activewal = active_wal.stdout.strip()

activewal = activewal.split()[2]
print(activewal)
next_wallpaper = get_next_wallpaper(activewal,wallpaper_files)
print(next_wallpaper)
change_wallpaper(wallpaper_dir+next_wallpaper)
generate_colorscheme(wallpaper_dir+next_wallpaper)
