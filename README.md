# Dotfiles 🚀

This repository contains all my configuration files (dotfiles) used to customize and automate my development environment,
mainly on macOS and Linux.

## Contents

- **.zshrc, .profile, .gitconfig**: Configuration files for Zsh shell, user profile, and Git.
- **brew_packages.txt**: List of Homebrew packages to quickly set up a new macOS environment.
- **arch.sh, ubuntu.sh, macos.sh**: Installation and setup scripts for Arch Linux, Ubuntu, and macOS.
- **proxy/**: Scripts to set up or remove a network proxy (`setup_proxy.sh`, `remove_proxy.sh`).
- **lockscreen.sh**: Script to lock the screen on Arch.

## Quick Installation

1. Clone this repository:

```sh
git clone https://github.com/your-username/dotfiles.git
cd dotfiles
```

2. Start automatic setup:

```sh
bash macos.sh
```

3. Link or copy the configuration files to your `$HOME`:

```sh
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.profile ~/.profile
ln -sf $(pwd)/.gitconfig ~/.gitconfig
```

4. (Optional) Set up the proxy if needed:

```sh
./proxy/setup_proxy.sh
```

## Why use these dotfiles?

- **Save time**: Quickly recreate a consistent development environment on any machine.
- **Customization**: All my preferences for the shell, Git, and other tools are centralized here.
- **Portability**: Works on macOS, Ubuntu, and Arch Linux.
