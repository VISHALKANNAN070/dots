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
alias ff="clear && fastfetch"

# PATH
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
