# dotfiles

~/.vimrc and ~/.gitconfig is symlinked (a shorcut) to their respective files in dotfiles directory

# vscode-config
🛠️ Setting Up Your VS Code Environment Using This Repo

    settings.json (UI/behavior preferences)
    keybindings.json (custom keyboard shortcuts)
    snippets/ (custom code snippets per language)
    extensions.txt (list of essential extensions)

🔧 Step 1: Clone the Repo

    ```
    git clone https://github.com/Junwo-o/vscode-config.git path/to/your/folder
    cd path/to/your/folder
    export VSCODE_CONFIG_PATH=$PWD

🔗 Step 2: Symlink Config Files to VS Code

    # Symlink settings.json
    ln -sf "$VSCODE_CONFIG_PATH/settings.json" \
       "$HOME/Library/Application Support/Code/User/settings.json"

    # Symlink keybindings.json (if it exists)
    ln -sf "$VSCODE_CONFIG_PATH/keybindings.json" \
       "$HOME/Library/Application Support/Code/User/keybindings.json"

    # Symlink snippets folder (if it exists)
    ln -sfn "$VSCODE_CONFIG_PATH/snippets" \
        "$HOME/Library/Application Support/Code/User/snippets"

💡 Step 3: Install Extensions

    To install all the extensions listed in extensions.txt:
    cat $VSCODE_CONFIG_PATH/extensions.txt | xargs -L 1 code --install-extension
    Make sure you have the code command available in your terminal first
    (Enable this in VS Code → Cmd+Shift+P → “Shell Command: Install ‘code’ command in PATH”)

🔄 To update your extension list:

    From inside your `vscode-config` folder (or any directory you prefer):
    
    code --list-extensions > extensions.txt

or

    code --list-extensions > "$VSCODE_CONFIG_PATH/extensions.txt":
