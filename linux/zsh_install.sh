#!/usr/bin/env bash

# Set current working directory
cwd=$(pwd)

# Install prerequisites
brew install git zsh bash stow

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
brew install git zsh bash stow


# Change default shell
echo ""
echo ">>> Change default shell to zsh"
chsh -s $(which zsh)
grep $USER /etc/passwd

# Install Meslo Font
echo ""
echo ">>> Installing font"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/Meslo/S/Regular/MesloLGSNerdFontMono-Regular.ttf

# Install powerlevel10k
brew install powerlevel10k
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install eza
brew install zoxide
brew install fzf fd

# Move back to the starting folder
cd $cwd
