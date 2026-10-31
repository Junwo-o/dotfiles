typeset -U path fpath cdpath

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

if command -v python3 >/dev/null 2>&1; then
    alias python='python3'
    alias pip='pip3'
fi

export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

alias kvim='NVIM_APPNAME=kickstart nvim'
alias lvim='NVIM_APPNAME=lazyvim nvim'

alias brew-server="brew bundle --file=~/dotfiles/Brewfile.server"
alias brew-desktop="brew bundle --file=~/dotfiles/Brewfile.desktop"

# If the server doesn't know what ghostty is, fallback to xterm-256color
if [[ "$TERM" == "xterm-ghostty" ]]; then
  if ! infocmp xterm-ghostty >/dev/null 2>&1; then
    export TERM=xterm-256color
  fi
fi

# vim motions within terminal
bindkey -v

PROMPT='%n@%m:%~%# '

fastfetch
