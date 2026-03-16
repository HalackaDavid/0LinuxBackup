echo "" > $HOME/.config/hypr/monitor.conf
if [[ "$(tty)" == /dev/tty1 ]]; then
        exec Hyprland >/dev/null;
fi
