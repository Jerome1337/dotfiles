#!/bin/sh

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
    && chmod +x minikube
sudo cp minikube /usr/local/bin \
    && rm minikube

#sudo snap install spotify
#for package in helm kubectl slack
#do
#    sudo snap install ${package} --classic
#done

if [[ ! -a $HOME/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [[ ! -a $HOME/.zplug ]]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

git clone https://github.com/Jerome1337/dotfiles.git $HOME/dotfiles

ln -sf $HOME/dotfiles/.profile $HOME/.profile
ln -sf $HOME/dotfiles/.zprofile $HOME/.zprofile
ln -sf $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/.gitconfig $HOME/.gitconfig
ln -sf $HOME/dotfiles/.gitignore_global $HOME/.gitignore_global
mkdir $HOME/.config/terminator

ln -sf $HOME/dotfiles/.config/terminator/config $HOME/.config/terminator/config

echo static "domain_name_servers=8.8.8.8 1.1.1.1" | sudo tee -a /etc/dhcpcd.conf

mkdir $HOME/Documents/Projets
