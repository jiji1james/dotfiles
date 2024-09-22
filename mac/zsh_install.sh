#!/usr/bin/env bash

brew install zsh

# Add shell environment
sudo sh -c 'echo /opt/homebrew/bin/zsh >> /etc/shells'

# Change shell
chsh -s /opt/homebrew/bin/zsh

# Install zsh plugins
brew install powerlevel10k
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install eza
brew install zoxide
brew install fzf fd

