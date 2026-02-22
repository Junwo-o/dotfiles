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
    if [ -f "$dest" ] && [ ! -L "$dest" ]; then
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
link_file "$DOTFILES_DIR/ghostty_config"  	"$HOME/.config/ghostty/config"
link_file "$DOTFILES_DIR/vim-config/vimrc"	"$HOME/.vimrc"
link_file "$DOTFILES_DIR/git-config/config"     "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/ghostty-config/config" "$HOME/.config/ghostty/config"
link_file "$DOTFILES_DIR/gitignore_global"	"$HOME/.gitignore_global"

echo "Done! Restart your terminal or run 'source ~/.zshrc' to see changes."
