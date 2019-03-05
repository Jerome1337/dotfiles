export ZSH="/home/jerome/.oh-my-zsh"
export FZF_BASE="~/.fzf"

# Using Pure prompt theme
ZSH_THEME=""

export UPDATE_ZSH_DAYS=7

plugins=(
  git
  fzf
  colorize
  history
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

alias gti="git"
alias project="cd ~/Documents/Projects"
alias projects="cd ~/Documents/Projects"

autoload -U promptinit; promptinit

prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"

export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$HOME/.local/share/JetBrains/Toolbox/bin:$PATH"

# Setup JetBrains IDE to PATH
typeset -A ides
ides=("PhpStorm" phpstorm "Goland" goland)

for key in "${(@k)ides}"; do
        ide=$ides[$key]

	if [[ ! -L "/usr/bin/$ide" ]]
	then
		echo "Creating $key alias"
		sudo ln -s $HOME/.local/share/JetBrains/Toolbox/apps/$key/ch-0/*/bin/$ide.sh /usr/bin/$ide
	fi
done

source ~/.zplug/init.zsh

zplug "docker/compose", as:command, from:gh-r, rename-to:docker-compose, \
  use:"*docker-compose-$(uname -s)-$(uname -m)"
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
zplug "junegunn/fzf", use:"shell/*.zsh", defer:2

zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zplug load
