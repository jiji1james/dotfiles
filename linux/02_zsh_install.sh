#!/usr/bin/env bash

# Set current working directory
cwd=$(pwd)

# Figure out if this is fedora/ubuntu
source /etc/os-release
echo ""
echo ">>> Linux OS Release: $PRETTY_NAME"

# Set OS Flags
if [[ $PRETTY_NAME == *"Ubuntu"* ]] || [[ $PRETTY_NAME == *"Kali"* ]]; then
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
  sudo dnf install -y curl wget tmux bash zsh which
elif $IS_UBUNTU; then
  sudo apt install -y curl wget tmux bash zsh which
fi

# Change default shell
echo ""
echo ">>> Change default shell to zsh"
chsh -s $(which zsh)
grep $USER /etc/passwd

# Install HomeBrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install ZSH Utils
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install eza
brew install zoxide
brew install fzf fd
brew install starship

# Move back to the starting folder
cd $cwd
