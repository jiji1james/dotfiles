#!/usr/bin/env bash

# # Install brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
# # Add to PATH
# eval "$(/opt/homebrew/bin/brew shellenv)"
#
# # Install bare minimum
# brew install git zsh bash stow
#
# # Add SHELL environment
# sudo sh -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
# sudo sh -c 'echo /opt/homebrew/bin/zsh >> /etc/shells'
# cat /etc/shells
# chsh -s /opt/homebrew/bin/zsh

# Files to be stowed
files=(
	".zprofile"
	".zshrc"
	".gitignore"
	".gitattributes"
	".gitconfig"
	".ideavimrc"
)

folders=(
	".config/wezterm"
	".config/iterm"
)

echo ""
while true; do
    read -p ">>>Applying stowed configuration files. Do you want to continue? (y/n): " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "Exiting..."; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo ""
echo ">>> Deleteing exiting config files"
for f in "${files[@]}"; do
	echo "Delete: $HOME/$f"
	rm -f "$HOME/$f" || true
done

echo ">>> Deleting exiting config folders"
for d in "${folders[@]}"; do
	echo "Delete: $HOME/$d"
	rm -rf "${HOME:?}/$d" || true
	mkdir -p "$HOME/$d"
done

echo ""
to_stow="$(find stow -type d -maxdepth 1 -mindepth 1 | awk -F "/" '{print $NF}' ORS=' ')"
IFS=' ' read -ra stow_array <<< "$to_stow"

# echo ">> to_stow: $to_stow"
# echo ">> stow_array: ${stow_array[@]}"

echo ""
echo ">>> Stowing config files"
for s in "${stow_array[@]}"; do
	echo ""
	echo ">> Stow: $s"
	stow -d stow --verbose 1 --target "$HOME" "$s"
done

