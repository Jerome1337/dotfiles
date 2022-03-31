#!/bin/bash

/bin/bash <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)

brew install $(<brew_packages.txt)

if [[ ! -a $HOME/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [[ ! -a $HOME/.zplug ]]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git clone https://github.com/Jerome1337/dotfiles.git $HOME/dotfiles

ln -sf $HOME/dotfiles/.profile $HOME/.profile
ln -sf $HOME/dotfiles/.zprofile $HOME/.zprofile
ln -sf $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/.gitconfig $HOME/.gitconfig
ln -sf $HOME/dotfiles/.gitignore_global $HOME/.gitignore_global
ln -sf $HOME/dotfiles/.alacritty.yml $HOME/.alacritty.yml
ln -sf $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf

for file in $(echo $HOME/dotfiles/.zshrc) $(echo $HOME/dotfiles/.gitconfig)
do
    sed -i "" 's#<gpg_binary>#'$(which gpg)'#' ${file}
done

mkdir -p $HOME/Documents/Projects

chsh -s /bin/zsh

echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.profile
