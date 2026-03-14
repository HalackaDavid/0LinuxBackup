if [ $(grep -H . /sys/class/drm/*/status | grep :disconnected | grep -v eDP) ] && [ $(uname -m) = "x86_64" ]; then
    echo "" > $HOME/.config/hypr/monitor.conf
    #echo "display seen $HOME/.config/hypr/monitor.conf"
    echo "MONITOR RELOADED"
fi

if [[ "$(tty)" == /dev/tty* ]]; then
    while true; do
        #clear
        print -n "[ ] Hyprland\n[1] Terminal\n>>> "
        read userInput
        case $userInput in
            "") exec Hyprland >/dev/null;;
            "1") break;;
        esac
    done
fi
