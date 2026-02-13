export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

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

