# statusbar
~/scripts/statusbar.sh &

# Load Wallpaper
feh --bg-fill ~/wallpapers/the-great-wave.png

# Load fonts
xset +fp /usr/share/fonts/local/

# Load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Start usb auto mount to /run/media/
~/scripts/udevadmmonitor.sh &

# Start battery notification scripts
~/scripts/battery_notify.sh &
~/scripts/charging_notify.sh &

# Start volume changing script
~/scripts/volume.sh &

usb-notify &

xscreensaver &

# Needed for dunst
systemctl --user import-environment DISPLAY

dunst &

# Start dwm
exec dwm
