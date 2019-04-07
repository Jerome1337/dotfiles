#!/bin/sh

set -e

useradd -m -g users -G wheel,storage,power -s /bin/bash jerome

passwd jerome

pacman -Syu --noconfirm alsa-utils \
    asciiquarium \
    compton \
    docker \
    firefox \
    fzf \
    git \
    gnupg \
    go \
    htop \
    i3-gaps \
    i3status \
    networkmanager \
    networkmanager-vpnc \
    nitrogen \
    ntfs-3g \
    numlockx \
    openssh \
    os-prober \
    playerctl \
    rofi \
    rxvt-unicode \
    screenfetch \
    sudo \
    terminator \
    ttf-dejavu \
    vim \
    xclip \
    xorg-server \
    xorg-xinit \
    xorg-xrdb \
    xdotool \
    xscreensaver \
    zsh

visudo

su - jerome

# Setup Yaourt
git clone https://aur.archlinux.org/package-query.git && \
    cd package-query && \
    makepkg -si --noconfirm && \
    cd .. && \
    git clone https://aur.archlinux.org/yaourt.git && \
    cd yaourt && \
    makepkg -si --noconfirm && \
    cd .. && \
    rm -rf package-query yaourt

yaourt -S --noconfirm nodejs \
    nerd-fonts-complete \
    polybar \
    snapd \
    steam

sudo systemctl start snapd && \
    systemctl enable -f snapd

sudo snap install spotify

sudo ln -sf /var/lib/snapd/snapd /snap

for package in goland phpstorm slack webstorm
do
    sudo snap install ${package} --classic
done

# Switch keyboard keymap
echo "KEYMAP=fr" > sudo /etc/vconsole.conf

# Fix GRUB entries
sudo os-prober
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Docker setup
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo gpasswd -a $(whoami) docker

if [[ ! -a $HOME/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [[ ! -a $HOME/.zplug ]]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

# Start services
sudo systemctl enable NetworkManager

git clone https://github.com/Jerome1337/dotfiles.git

ln -sf $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/.gitconfig $HOME/.gitconfig
ln -sf $HOME/dotfiles/.gitignore_global $HOME/.gitignore_global

mkdir -p $HOME/.config/i3
ln -sf $HOME/dotfiles/.config/i3/config $HOME/.config/i3/config

mkdir $HOME/.config/polybar
ln -sf $HOME/dotfiles/.config/polybar/config $HOME/.config/polybar/config
ln -sf $HOME/dotfiles/.config/polybar/bar_launch.sh $HOME/.config/polybar/bar_launch.sh
ln -sf $HOME/dotfiles/lockscreen.sh $HOME/lockscreen.sh

mkdir $HOME/.config/terminator
ln -sf $HOME/dotfiles/.config/terminator/config $HOME/.config/terminator/config

sudo chsh -s /bin/zsh $(whoami)

sudo reboot
