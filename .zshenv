#exports must be up
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

#if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#    exec Hyprland >/dev/null
#fi

if [[ "$(tty)" == /dev/tty* ]] && [[ "$(uname -m)" = "x86_64" ]]; then
        echo "is tty ($(date))" >> ~/a.txt
fi

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

