wbg -s ~/backgrounds/evening-sky.png & 
wl-paste --watch cliphist store &
someblocks &
mako &

export XDG_CURRENT_DESKTOP=wlroots 
export XDG_SESSION_TYPE=wayland

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

notify-send -c centered "Welcome" "Om Namah Bhagavate Vasudevaya Namah"
