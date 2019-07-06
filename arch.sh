#!/bin/sh

set -e

useradd -m -g users -G wheel,storage,power -s /bin/bash jerome

passwd jerome

pacman -Syu --noconfirm alsa-utils \
    asciiquarium \
    compton \
    dep \
    docker \
    docker-compose \
    firefox \
    fzf \
    git \
    gnupg \
    go \
    htop \
    i3-gaps \
    i3status \
    linux-headers \
    networkmanager \
    networkmanager-openconnect \
    networkmanager-vpnc \
    nitrogen \
    npm \
    ntfs-3g \
    numlockx \
    openconnect \
    openssh \
    os-prober \
    playerctl \
    python \
    python-pip \
    rofi \
    rxvt-unicode \
    screenfetch \
    sudo \
    terminator \
    ttf-dejavu \
    udisks2 \
    vim \
    virtualbox-host-modules-arch \
    virtualbox \
    whois \
    xclip \
    xorg-server \
    xorg-xinit \
    xorg-xrdb \
    xorg-xrandr \
    xdotool \
    xscreensaver \
    zsh

visudo

su - jerome <<EOSU

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

yaourt -S --noconfirm go-ling-git
    google-chrome \
    i3lock-fancy-git \
    nodejs \
    nerd-fonts-complete \
    polybar \
    snapd

sudo systemctl start snapd && \
    systemctl enable -f snapd

# Install Minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
    && chmod +x minikube
sudo cp minikube /usr/local/bin \
    && rm minikube

sudo snap install spotify

sudo ln -sf /var/lib/snapd/snap /snap

for package in goland helm kubectl phpstorm pycharm-professional slack webstorm
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

ln -sf $HOME/dotfiles/.screenlayout $HOME/.screenlayout
ln -sf $HOME/dotfiles/.Xresources $HOME/.Xresources
ln -sf $HOME/dotfiles/.xinitrc $HOME/.xinitrc
ln -sf $HOME/dotfiles/.profile $HOME/.profile
ln -sf $HOME/dotfiles/.zprofile $HOME/.zprofile
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

echo static "domain_name_servers=8.8.8.8 1.1.1.1" | sudo tee -a /etc/dhcpcd.conf

sudo chsh -s /bin/zsh $(whoami)

EOSU

reboot
