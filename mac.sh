#!/bin/bash

DOTFILES_DIR=~/dev/dotfiles

# Install Homebrew if it's missing
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Brewfile packages
echo "Installing Brewfile packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Install stow if missing
if ! command -v stow >/dev/null 2>&1; then
  echo "Installing stow..."
  brew install stow
fi

# Stow dotfiles
echo "Stowing dotfiles..."
cd "$DOTFILES_DIR" || exit
stow zsh bash vim git ghostty ticker lazyvim

DEV_DIR="$HOME/Dev"
if [ ! -d "$DEV_DIR" ]; then
  echo "Creating $DEV_DIR..."
  mkdir -p "$DEV_DIR"
else
  echo "$DEV_DIR already exists, skipping creation."
fi
cd "$DEV_DIR" || exit

USERNAME="Junwo-o"

REPOS=(
  "algorithmictrading"
  "dotfiles"
  "notes"
  "journal"
  "junwo-o.github.io"
)

for REPO in "${REPOS[@]}"; do
  if [ ! -d "$REPO" ]; then
    echo "Cloning $REPO..."
    git clone "https://github.com/$USERNAME/$REPO.git"
  else
    echo "$REPO already exists. Pulling latest updates..."
    (cd "$REPO" && git pull)
  fi
done

echo "Installation complete! Reloading shell..."

exec zsh -l
