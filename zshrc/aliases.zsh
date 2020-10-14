# Make core utils better
alias grep='grep --color=auto'
alias ls='exa --color=auto'
alias cat='bat'

alias ssh='export TERM=xterm-256color && ssh'

export TIME_STYLE=long-iso # makes YYYY-MM-DD in the ls output
export BLOCK_SIZE="'1" # makes 1,000,000 for big sizes

# Common commands

alias fd="fdfind"

hash_directory() {
    tar cf - "$1" | sha1sum | cut -d" " -f1 | head -c5
    echo ""
}

alias feh="feh --scale-down --auto-zoom"
