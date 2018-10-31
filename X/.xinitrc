# statusbar 
slstatus &

# Background color
xsetroot -solid "#002b36"

# Load fonts
xset +fp /usr/share/fonts/local/

# Load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Start dwm
exec dwm
