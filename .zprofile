if [ $(grep -H . /sys/class/drm/*/status | grep :connected | grep -v eDP) ] && [ $(uname -m) = "x86_64" ]; then
    echo "" > $HOME/.config/hypr/monitor.conf
fi

if [[ "$(tty)" == /dev/tty* ]]; then
    while true; do
        print -n "[1] Hyprland\n[2] Terminal\n>>> "
        read userInput
        case $userInput in
            "1") exec Hyprland >/dev/null;;
            "2") break;;
            *) ;;
        esac
    done
fi
