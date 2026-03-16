#if [ $(grep -H . /sys/class/drm/*/status | grep :disconnected | grep -v eDP) ] && [ $(uname -m) = "x86_64" ]; then
#    echo "" > $HOME/.config/hypr/monitor.conf
#    echo "MONITOR RELOADED"
#    sleep 3
#fi
    
echo "" > $HOME/.config/hypr/monitor.conf
if [[ "$(tty)" == /dev/tty1 ]]; then
        exec Hyprland >/dev/null;
fi
