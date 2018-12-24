# statusbar 
~/scripts/statusbar.sh &

# Load Wallpaper
feh --bg-fill ~/wallpapers/Solarized_Arch_Wallpaper.png

# Load fonts
xset +fp /usr/share/fonts/local/

# Load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Start dwm
exec dwm
