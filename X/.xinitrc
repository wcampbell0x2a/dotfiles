# statusbar 
slstatus &

# Load wallpaper
#feh --bg-fill /home/waynecampbell/Projects/dwm/patches/wallpaper.jpg

# Load fonts
xset +fp /usr/share/fonts/local/

# Load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

#Setup monitor for work
if [[ $2 == "work" ]]; then
xrandr --output VIRTUAL1 --off --output DP3 --mode 2560x1080 --pos 3200x504 --rotate normal --output DP1 --mode 1920x1080 --pos 5760x0 --rotate right --output eDP1 --primary --mode 3200x1800 --pos 0x504 --rotate normal --output DP2 --off
fi

if [[ $2 == "laptop" ]]; then
    xrandr --output eDP1 --mode 2560x1080
fi

# Start dwm
exec dwm
