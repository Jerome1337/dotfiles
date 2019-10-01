#!/bin/bash

sudo apt update
sudo apt -y install apt-transport-https \
    ca-certificates \
    curl \
    fzf \
    git \
    gnupg-agent \
    go-dep \
    software-properties-common \
    screenfetch \
    vim \
    wget

# Setup Docker Engine
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

# Setup Visual Studio Code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://packages.microsoft.com/repos/vscode \
    stable main"

sudo apt update
sudo apt -y install code \
    containerd.io \
    docker-ce \
    docker-ce-cli

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

sudo systemctl enable docker

# Install Docker compose
COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | \
    grep refs/tags | \
    grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
    && chmod +x minikube

sudo cp minikube /usr/local/bin \
    && rm minikube

sudo snap install htop rocketchat-desktop spotify
for package in code go helm kubectl slack
do
    sudo snap install ${package} --classic
done

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

if [[ ! -d $HOME/.config/terminator ]]; then
    mkdir $HOME/.config/terminator
fi

ln -sf $HOME/dotfiles/.config/terminator/config $HOME/.config/terminator/config

mkdir $HOME/Documents/Projects
