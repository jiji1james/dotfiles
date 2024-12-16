#!/usr/bin/env bash

# Set current working directory
cwd=$(pwd)

# Figure out if this is fedora/ubuntu
source /etc/os-release
echo ""
echo ">>> Linux OS Release: $PRETTY_NAME"

# Install pre-requisite software
if $IS_UBUNTU; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y git stow bash zsh zip unzip dos2unix build-essential
elif $IS_FEDORA; then
  sudo dnf update
  sudo dnf install -y git stow bash zsh zip unzip dos2unix build-essential
fi

# Set OS Flags
if [[ $PRETTY_NAME == *"Ubuntu"* ]]; then
  export IS_UBUNTU=true
  export IS_FEDORA=false
elif [[ $PRETTY_NAME == *"Fedora"* ]]; then
  export IS_UBUNTU=false
  export IS_FEDORA=true
fi

# Files to be stowed
files=(
  ".zprofile"
  ".zshrc"
  ".bash_profile"
  ".bashrc"
  ".gitignore"
  ".gitattributes"
  ".gitconfig"
  ".ideavimrc"
  ".tmux.conf"
  ".config/starship.toml"
)

folders=(
  ".config/nvim"
)

echo ""
while true; do
  read -p ">>>Applying stowed configuration files. Do you want to continue? (y/n): " yn
  case $yn in
  [Yy]*) break ;;
  [Nn]*)
    echo "Exiting..."
    exit
    ;;
  *) echo "Please answer yes or no." ;;
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
IFS=' ' read -ra stow_array <<<"$to_stow"

# echo ">> to_stow: $to_stow"
# echo ">> stow_array: ${stow_array[@]}"

echo ""
echo ">>> Stowing config files"
for s in "${stow_array[@]}"; do
  echo ""
  echo ">> Stow: $s"
  stow -d stow --verbose 1 --target "$HOME" "$s"
done
