#alias vim="/usr/local/bin/vim"
alias python='python3'

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads Node Version Manager

cat << "EOF"
  /\_/\
 ( o.o )
  > ^ <
EOF

# 1. Use the Silicon Homebrew by default
export PATH="/opt/homebrew/bin:$PATH"

# 2. Create a shortcut for the old Intel version
alias ibrew='arch -x86_64 /usr/local/bin/brew'

# vim motions within terminal
bindkey -v
