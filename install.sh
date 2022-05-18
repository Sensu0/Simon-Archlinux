#!/bin/bash

echo "Copying pacman, rofi and awesome config files recursively
"
sudo cp -vr pacman.conf /etc/pacman.conf
cp -vr .vimrc ~/.vimrc
cp -vr rofi ~/.config/rofi || \
(mkdir -v ~/.config/rofi ~/.config/awesome && \
cp -vr rofi ~/.config/rofi)
cp -vr awesome ~/.config/awesome

# This will install all packages I use in Arch Linux.
# 
# By putting two "`" between the comments, it will allow for input of commands
# before and after comments in the same line. The "\" will make the script ignore
# whatever comes after it. Thus allowing us to make a new line after it.
#
sudo pacman -Syu --noconfirm

# Install AUR helper yay

mkdir -p ~/git-clones
git clone https://aur.archlinux.org/yay.git ~/git-clones/yay
cd ~/git-clones/yay
makepkg -si --noconfirm && cd - && \
\
`# Proceed and install all the software` \
\
\
`# WM and xorg` \
yay -S --noconfirm --noremovemake --nocleanafter --noredownload \
--batchinstall --norebuild --sudoloop awesome xorg xorg-xinit \
`# tools` \
vim libreoffice-still libreoffice-still-sv virtualbox cronie rclone lxinput kvantum-qt5 man-pages \
\
okular hplip glances man tldr base-devel pcmanfm qterminal openssh alsa-utils \
\
gimp wget bash zsh links kdeconnect ranger i3lock lxappearance \
\
woeusb unetbootin qt5ct pavucontrol volumeicon calc \
\
`# system tools ` \
htop gnome-disk-utility gparted bpytop lshw neofetch \
\
`# multimedia and entertainment` \
kdenlive vlc obs-studio subtitleeditor ristretto makemkv \
\
`# Internet` \
firefox brave-bin google-chrome qbittorrent thunderbird nordvpn-bin davmail \
\
`# gaming` \
discord pcsx2 dolphin-emu duckstation-git kega-fusion rpcs3-git mupen64plus-git m64py \
\
mednaffe agg desmume-git snes9x-gtk vbam-wx mednafen ppsspp \
\
`# fonts` \
noto-fonts-cjk noto-fonts noto-fonts-emoji ttf-win10 \
\
ttf-ms-fonts powerline-fonts awesome-terminal-fonts ttf-dejavu \
\
`# other` \
slack-desktop teamviewer discord-rpc-api vimix-icon-theme breeze breeze-gtk \
\
xpadneo-dkms vim-tabnine-git vim-badwolf-git ksnip-git woeusb
#
# Load sg kernel module for makemkv
sudo echo sg > /etc/modules-load.d/sg.conf
#
# Enable and start necessary sockets. Services are used when a socket is not available
sudo systemctl enable --now bluetooth.service teamviewerd.service sshd.service nordvpnd.socket

user=$(whoami)

sudo usermod -aG wheel,games,nordvpn,audio $user  
#
# Install omz and plugins
#
# Use sed to prevent zsh from launching/rebooting after omz has installed
# This will make it possible to execute commands after omz installation.
sh -c "$(curl -fsSLo ~/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sed 's/exec zsh -l//g')"

echo "
Copying .zprofile, .zshrc and xinitrc recursively.
"
cp -vr .zprofile .zshrc xinitrc ~/

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
~/.oh-my-zsh/custom/themes/powerlevel10k
# Always merge on git pull
cd ~/.oh-my-zsh/custom/themes/powerlevel10k
git config pull.rebase false
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions \
~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
cd ~/.oh-my-zsh/custom/plugins/

# Need to chmod for custupdate function to work (see .zshrc)
chmod -R 755 ./zsh-syntax-highlighting/ ./zsh-autosuggestions/
cd zsh-autosuggestions
git config pull.rebase false
cd ../zsh-syntax-highlighting
git config pull.rebase false

# Set global git configs for machine
echo " 
All software is now installed. If you plan on using 'git',
then please input name, email and default editor to set it globally.
If you don't want this, just press 'Ctrl+C' to end this script.

"
read -p "What is EDITOR do you want to set as default for 'git'?
" $editor
git config --global core.editor "$editor"
read -p "What is EMAIL do you want to set as default for 'git'?
" $email
git config --global user.email "$email"
read -p "What is NAME do you want to set as default for 'git'?
" $name
git config --global user.name "$name"
#
echo "
Almost done. If you don't see any errors, then just reboot the system and you'll be done with this."
