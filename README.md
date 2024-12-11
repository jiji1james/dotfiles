# Setting up Ubuntu in WSL
Copy ssh keys from windows. Replace *JijiJames* with the windows username.
```
cp -r /mnt/c/Users/JijiJames/.ssh ~/
```
Refresh the repositories
```
sudo apt update
sudo apt upgrade -y
```
Install basic software
```
sudo apt install -y git stow bash zsh zip unzip dos2unix build-essential
```
Fix the ssh keys
```
cd ~/.ssh
chmod 400 id_*
chmod 400 keys/*pem
find . -type f -exec dos2unix {} +
cd ~
```
Setup linux environment using the dotfiles. These commands will ask for your password a few times.
```
cd ~/dotfiles/linux
./01_dotfiles_install.sh
./02_zsh_install.sh
```
Install additional softwares
```
sudo apt install -y bat neovim
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
```
