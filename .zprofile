#print ".zprofile"

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
