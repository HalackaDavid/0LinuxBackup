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

case $(uname -m) in 
aarch64)
    export myDevicePath=/dev/block
    ;;
x86_64)
    export myDevicePath=/dev
    ;;
esac

export myData=$HOME/data
export myAppsPath=$myData/Apps
export myFSPath=/mnt

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export EDITOR="nvim"
export PULSE_COOKIE="$HOME/.cache/pulse/cookie"
export PYTHON_HISTORY="$HOME/.cache/python/history"

var="$myAppsPath/App:$HOME/.local/bin"
export PATH="$var:$PATH"

autoload -U colors && colors
PS1=$'%F{244}%B[%b%F{247}%n%F{250}%B@%b%F{247}%m%F{244}%B]-%b%F{244}%B[%b%F{256}%~%F{244}%B]%b\n%F{247}%B>>>%f%b%k '

setopt autocd              # change directory just by typing its name
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# ZSH history file
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

# Fancy auto-complete
autoload -Uz compinit
zstyle ':completion:*' menu select=0
zmodload zsh/complist
zstyle ':completion:*' format '>>> %d'
#compinit
_comp_options+=(globdots) # hidden files are included

# enable completion features
#autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#nvim cursors
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]]; then
        echo -ne '\e[2 q'  # block cursor
    else
        echo -ne '\e[6 q'  # vertical bar
    fi
}
precmd_functions+=(zle-keymap-select)
zle -N zle-keymap-select

################
### KEYBINDS ###
################
# cat -v can be used for see what exact key sequence is for my terminal
#
# Keybindings section
#bindkey -e #emacs keybinds
export KEYTIMEOUT=1
bindkey -v '^?' backward-delete-char
bindkey ' ' magic-space

#Home key
bindkey '^[[7~' beginning-of-line
bindkey '^[[H' beginning-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[[1~' beginning-of-line

#End key
bindkey '^[[4~' end-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[F' end-of-line 

#Insert key
bindkey '^[[2~' overwrite-mode

#Delete key
bindkey '^[[3~' delete-char

#Right arrow key
bindkey '^[[C'  forward-char

#Left arrow key
bindkey '^[[D'  backward-char

#Page up key
bindkey '^[[5~' history-beginning-search-backward

#Page down key
bindkey '^[[6~' history-beginning-search-forward

# Navigate words with ctrl+arrow keys
#Ctrl + right arrow key
bindkey '^[[1;5C' forward-word
bindkey '^[Oc' forward-word

#Ctrl + left arrow key
bindkey '^[[1;5D' backward-word
bindkey '^[Od' backward-word

#Ctrl + backspace
bindkey '^H' backward-kill-word

#Shift + tab
bindkey '^[[Z' undo

# enable syntax-highlighting
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[path]=bold
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
    ZSH_HIGHLIGHT_STYLES[named-fd]=none
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
fi

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

# enable auto-suggestions based on the history
#if [ -f ~/.myzsh/my_zsh_autosuggestions ]; then
#    . ~/.myzsh/my_zsh_autosuggestions
#    # change suggestion color
#    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
#fi

#Aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias lnc='ls --color=none'
alias ls='ls --group-directories-first --color=auto'
alias l='ls'
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -la'
alias tree='tree --dirsfirst -a'
alias date='TZ="Europe/Prague" date +"%d.%m.%Y-%Hh%Mm%Ss"'
alias c='clear'
alias ff='fastfetch'
alias neton='sudo systemctl start iwd'
alias netoff='sudo systemctl stop iwd'

alias bashF='rm ~/.bashrc ~/.bash_profile ~/.bash_logout ~/.profile ~/.bash_login ~/.bash_history 2>/dev/null'
alias hpr='echo "" > ~/.config/hypr/monitor.conf'

unset var;
