# statusbar 
slstatus &

# Load wallpaper
feh --bg-fill /home/waynecampbell/Projects/dwm/patches/wallpaper.jpg

# Load fonts
xset +fp /usr/share/fonts/local/

# Load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Start dwm
exec dwm
