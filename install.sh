#!/bin/sh
# copy pacman config before executing pacman
# also
sudo cp -vr pacman.conf /etc/pacman.conf && \
cp -vr .vimrc ~/.vimrc

# This will install all packages I use in Arch Linux.
# 
# By putting two "`" between the comments, it will allow for input of commands
# before and after comments in the same line. The "\" will make the script ignore
# whatever comes after it. Thus allowing us to make a new line after it.
#
sudo pacman -Syu

# Install AUR helper yay

mkdir -p ~/git-clones
git clone https://aur.archlinux.org/yay.git ~/git-clones/yay
cd ~/git-clones/yay
makepkg -si --noconfirm && \
\
`# Proceed and install all the software` \
\
`# WM and xorg` \
yay -S --noconfirm --sudoloop awesome xorg \
`# Testing` \
zsh man pulseaudio pulseaudio-alsa themix-full-git qt5ct tldr vim wget brave-bin
#`# tools` \
#vim libreoffice-still libreoffice-still-sv virtualbox cronie rclone lxinput \
#\
#okular hplip glances man tldr base-devel pcmanfm qterminal pulseaudio-alsa \
#\
#gimp wget bash zsh links kdeconnect ranger i3lock pulseaudio themix-full-git \
#\
#woeusb unetbootin qt5ct \
#\
#`# system tools ` \
#htop gnome-disk-utility gparted bashtop lshw neofetch \
#\
#timeshift \
#\
#`# multimedia and entertainment` \
#kdenlive vlc obs-studio subtitleeditor ristretto makemkv \
#\
#spotify electronplayer \
#\
#`# Internet` \
#firefox brave-bin google-chrome qbittorrent thunderbird windscribe \
#\
#`# gaming` \
#steam lutris discord \
#\
#`# emulators` \
#pcsx2-64bit-git dolphin-emu-beta-git duckstation-git kega-fusion rpcs3-git mupen64plus-git m64py \
#\
#mednaffe desmume-git snes9x-gtk vbam-wx mednafen ppsspp \
#\
#`# fonts` \
#noto-fonts-cjk noto-fonts noto-fonts-emoji ttf-win10 \
#\
#ttf-ms-fonts steam-fonts ttf-dejavu-sans-mono-powerline-git \
#\
#`# other` \
#slack-desktop teamviewer discord-rpc-api \
#\
#xpadneo vim-tabnine-git vim-badwolf-git ksnip-git woeusb 
#
# Enable and start necessary services for Teamviewer and Windscribe
#
#sudo systemctl enable teamviewerd.service windscribe.service
#sudo systemctl start teamviewerd.service windscribe.service
#
# Install omz and plugins

cd
# Use sed to prevent zsh from launching/rebooting after omz has installed
# This will make it possible to execute commands after omz installation.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sed 's/exec zsh -l//g')"
cd -
cp -vr .zprofile .zshrc ~/
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
# Always merge on git pull
cd ~/.oh-my-zsh/custom/themes/powerlevel10k
git config pull.rebase false
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
cd ~/.oh-my-zsh/custom/plugins/
chmod -R 755 ./zsh-syntax-highlighting/ ./zsh-autosuggestions/
cd zsh-autosuggestions
git config pull.rebase false
cd ../zsh-syntax-highlighting
git config pull.rebase false
