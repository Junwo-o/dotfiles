alias vim="/usr/local/bin/vim" #Configured to use a newer version of Vim installed via Homebrew
alias python='python3'

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads Node Version Manager
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads Node Version Manager's auto completion

cat << "EOF"
  /\_/\
 ( o.o )
  > ^ <
EOF

# 1. Use the Silicon Homebrew by default
export PATH="/opt/homebrew/bin:$PATH"

# 2. Create a shortcut for the old Intel version
alias ibrew='arch -x86_64 /usr/local/bin/brew'
