waybar  -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css > /dev/null 2>&1 &
swaybg -i ~/backgrounds/book-dark.jpg -m fill > /dev/null 2>&1 &
 
kitty > /dev/null 2>&1 &
# cliphist daemon
wl-paste --watch cliphist store > /dev/null 2>&1 &
mako &

