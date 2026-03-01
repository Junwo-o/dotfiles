#!/bin/bash

# Define the dotfiles directory
DOTFILES_DIR=~/dev/dotfiles
OS_TYPE=$(uname -s)

# Install Homebrew if it's missing
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # On Linux, Homebrew needs to be added to the PATH immediately to be used
  if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "linux"* ]]; then
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# Ensure brew is available in the current script session
if [[ -d /home/linuxbrew/.linuxbrew ]]; then
  # Linux (VMs)
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
  # Apple Silicon Mac (M1 Mac Mini)
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  # Intel Mac (MacBook)
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Homebrew Setup (Cross-Platform)
if [[ -f /opt/homebrew/bin/brew ]]; then
  # For M1/M2/M3 Macs
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  # For Linux/Ubuntu VMs
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  # For Intel Macs
  eval "$(/usr/local/bin/brew shellenv)"
fi

BREWFILE="$DOTFILES_DIR/Brewfile"
HASH_FILE="$HOME/.brewfile_hash"

# "./install.sh --brew" in order to sync brew
if [[ "$1" == "--brew" ]]; then
  echo "Checking Homebrew dependencies..."
  if command -v md5 >/dev/null; then
    CURRENT_HASH=$(md5 -q "$BREWFILE")
  else
    CURRENT_HASH=$(md5sum "$BREWFILE" | awk '{ print $1 }')
  fi
  LAST_HASH=$(cat "$HASH_FILE" 2>/dev/null)
  if [ "$CURRENT_HASH" != "$LAST_HASH" ]; then
    echo "Changes detected in Brewfile. Running bundle..."
    brew bundle --file="$BREWFILE" --no-upgrade
    echo "$CURRENT_HASH" >"$HASH_FILE"
  else
    echo "Brewfile is unchanged. No installation needed."
    echo "Tip: Run 'brew upgrade' manually if you just want to update apps."
  fi
fi

if [ "$OS_TYPE" == "Linux" ]; then
  echo "Detected Linux."

  if ! command -v zsh >/dev/null 2>&1; then
    if [ -w "/etc/shadow" ] || sudo -n true 2>/dev/null; then
      echo "Sudo detected. Installing Zsh via apt..."
      sudo apt update && sudo apt install zsh -y
    else
      echo "No sudo privileges. Please ask your admin to install Zsh,"
      echo "or use a portable Zsh binary in ~/bin."
    fi
  fi
fi

# Install system dependencies if on Linux
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "linux"* ]]; then
  echo "Linux detected: Installing core dev tools..."
  sudo apt update && sudo apt install -y build-essential curl git
fi

# Function to create symlinks
# Usage: link_file <source_in_dotfiles> <target_destination>
link_file() {
  local src=$1
  local dest=$2

  # Create parent directory if it doesn't exist (e.g., for .config/ghostty)
  mkdir -p "$(dirname "$dest")"

  # If the destination exists and is not a symlink, back it up
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up existing file: $dest to $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  # Create the symlink (the -f flag forces it to overwrite old symlinks)
  echo "Linking $dest -> $src"
  ln -sfn "$src" "$dest"
}

echo "Starting dotfiles installation..."

# --- Add your files here ---
link_file "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"
link_file "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
link_file "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/ghosttyconfig" "$HOME/.config/ghostty/config"
link_file "$DOTFILES_DIR/gitignore_global" "$HOME/.gitignore_global"
link_file "$DOTFILES_DIR/lazyvim" "$HOME/.config/lazyvim"

# --- Set Zsh as Default (Universal) ---
ZSH_PATH=""

if [[ -f /opt/homebrew/bin/zsh ]]; then
  ZSH_PATH="/opt/homebrew/bin/zsh" # M1 Mac
elif [[ -f /usr/local/bin/zsh ]]; then
  ZSH_PATH="/usr/local/bin/zsh" # Intel Mac
elif [[ -f /home/linuxbrew/.linuxbrew/bin/zsh ]]; then
  ZSH_PATH="/home/linuxbrew/.linuxbrew/bin/zsh" # Linuxbrew
elif [[ -f /usr/bin/zsh ]]; then
  ZSH_PATH="/usr/bin/zsh" # Standard Linux
fi

if [[ -n "$ZSH_PATH" && "$SHELL" != "$ZSH_PATH" ]]; then
  echo "Switching to Zsh at $ZSH_PATH..."
  if ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
  fi
  if [ "$OS_TYPE" == "Linux" ]; then
    sudo chsh -s "$ZSH_PATH" "$USER"
  else
    chsh -s "$ZSH_PATH"
  fi
fi

HOSTNAME=$(hostname)
if [ ! -f ~/.ssh/id_ed25519 ]; then
  ssh-keygen -t ed25519 -C "junwoo@$HOSTNAME" -N "" -f ~/.ssh/id_ed25519
fi

echo "Installation complete! Reloading shell..."

exec zsh -l
