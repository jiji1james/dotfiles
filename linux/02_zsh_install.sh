#!/usr/bin/env bash

# Set current working directory
cwd=$(pwd)

# Figure out if this is fedora/ubuntu
source /etc/os-release
echo ""
echo ">>> Linux OS Release: $PRETTY_NAME"

# Set OS Flags
if [[ $PRETTY_NAME == *"Ubuntu"* ]]; then
	export IS_UBUNTU=true
	export IS_FEDORA=false
elif [[ $PRETTY_NAME == *"Fedora"* ]]; then
	export IS_UBUNTU=false
	export IS_FEDORA=true
fi

# Install ZSH
echo ""
echo ">>> Installing zsh & other prerequisites"
if $IS_FEDORA; then
	sudo dnf install -y curl wget tmux
elif $IS_UBUNTU; then
	sudo apt install -y curl wget tmux
fi

# Change default shell
echo ""
echo ">>> Change default shell to zsh"
chsh -s $(which zsh)
grep $USER /etc/passwd

# Install ZSH Utils
curl -s https://ohmyposh.dev/install.sh | bash -s
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install eza
brew install zoxide
brew install fzf fd

# Move back to the starting folder
cd $cwd
