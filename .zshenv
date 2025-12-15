if command -v tmux >/dev/null 2>&1; then
    if [[ -z "$TMUX" ]] && [[ -o interactive ]] && [[ -t 0 ]]; then
        if ! tmux list-sessions 2>/dev/null | grep -q '^D.*(attached)'; then
            exec tmux new-session -A -s D
        else
            exec zsh
        fi
    fi
fi

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
