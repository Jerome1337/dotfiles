export ZSH="/home/jerome/.oh-my-zsh"

source $HOME/.zplug/init.zsh

zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"
zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

LOAD_FLAGS=""
if ! zplug check --verbose; then
	LOAD_FLAGS="--verbose"
	zplug install
fi

zplug load ${LOAD_FLAGS}

export UPDATE_ZSH_DAYS=7

ZSH_THEME=""

plugins=(
  git
  fzf
  colorize
  history
  docker-compose
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

alias gti="git"
alias project="cd ~/Documents/Projects"
alias projects="cd ~/Documents/Projects"

prompt_newline='%666v'
PROMPT=" $PROMPT"

export PATH="$PATH:$HOME/.rvm/bin"

source ~/.zplug/init.zsh
