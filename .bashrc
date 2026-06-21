# History
HISTFILE="$HOME/.histfile"
HISTSIZE=10000
HISTFILESIZE=10000

# Prompt
PS1='(\u) \w \$ '

# Aliases
alias c="clear"
alias q="exit"
alias v="nvim"
alias l="xbps-query -Rs"
alias g="sudo xbps-install -S"
alias f="yazi"
alias ff="$HOME/dotfiles/scripts/fetch.sh"
alias lc="$HOME/Localsend/localsend_app"

# PATH
export PATH="$HOME/.local/bin:$PATH"
