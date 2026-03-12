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
else

    if (( $+commands[tmux] )) && [[ -z $TMUX && $- == *i* && -t 0 ]]; then
        if ! tmux list-sessions 2>/dev/null | grep -q '^D.*(attached)'; then
            exec tmux new-session -A -s D
        else
            clear
            echo "[1] zsh shell"
            echo "[2] tmux new session"
            echo "[*] tmux default session"
            read UserInput
            clear
            case $UserInput in
            1) unset UserInput;;
            2) exec tmux;;
            *) exec tmux new-session -A -s D;;
            esac
            unset UserInput
        fi
    fi
fi
