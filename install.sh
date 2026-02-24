#!/bin/bash

# Define the dotfiles directory
DOTFILES_DIR=~/dev/dotfiles

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
    ln -sf "$src" "$dest"
}

echo "Starting dotfiles installation..."

# --- Add your files here ---
link_file "$DOTFILES_DIR/zshrc"           	"$HOME/.zshrc"
link_file "$DOTFILES_DIR/vimrc"			"$HOME/.vimrc"
link_file "$DOTFILES_DIR/gitconfig"     	"$HOME/.gitconfig"
link_file "$DOTFILES_DIR/ghosttyconfig" 	"$HOME/.config/ghostty/config"
link_file "$DOTFILES_DIR/gitignore_global"	"$HOME/.gitignore_global"
link_file "$DOTFILES_DIR/lazyvim"		"$HOME/.config/lazyvim"

echo "Done! Restart your terminal or run 'source ~/.zshrc' to see changes."
