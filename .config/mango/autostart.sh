waybar  -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css > /dev/null 2>&1 &
wbg ~/backgrounds/cat_leaves.png -s &
 
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
/usr/lib/xdg-desktop-portal-wlr &

# foot > /dev/null 2>&1 &
# cliphist daemon
wl-paste --watch cliphist store > /dev/null 2>&1 &
mako &
notify-send -c centered "Welcome" "Om Namah Bhagavate Vasudevaya Namah"
