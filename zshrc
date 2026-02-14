alias vim="/usr/local/bin/vim" #Configured to use a newer version of Vim installed via Homebrew
alias python='python3'

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export PATH="/Applications/IntelliJ IDEA CE.app/Contents/MacOS:$PATH" # This allows IntelliJ's CLI Tools

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads Node Version Manager
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads Node Version Manager's auto completion

cat << "EOF"
  /\_/\
 ( o.o )
  > ^ <
EOF

export PATH="$PATH:/Users/junwoolee/dev/worldbanc/private/bin"
alias python=python3
