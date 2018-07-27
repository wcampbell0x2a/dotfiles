# statusbar loop
while true; do
   xsetroot -name "$( date +"%F %R" )"
   sleep 1m    # Update time every minute
done &

# Autostart section
feh --bg-fill /home/waynecampbell/Projects/dwm/patches/wallpaper.jpg

exec dwm
