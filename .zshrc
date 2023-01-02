if [ "$TMUX" = "" ]; then tmux; fi

export ZSH="$HOME/.oh-my-zsh"
export FZF_BASE=$(which fzf)

source $HOME/.zplug/init.zsh

zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"
zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, as:theme

LOAD_FLAGS=""
if ! zplug check --verbose; then
  LOAD_FLAGS="--verbose"
  zplug install
fi

zplug load ${LOAD_FLAGS}

export UPDATE_ZSH_DAYS=7

ZSH_THEME=""

plugins=(
  colorize
  docker-compose
  fzf
  git
  history
  tmux
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

alias gti="git"
alias g="git"
alias project="cd ~/Documents/Projects"
alias projects="cd ~/Documents/Projects"
alias n="npm"
alias nr="npm run"
alias vim="nvim"
alias y="yarn"
alias yr="yarn run"
alias yw="yarn workspace"
alias yws="yarn workspaces"
alias vim="nvim -S ~/.vimrc"

prompt_newline='%666v'
PROMPT=" $PROMPT"

export PATH=<gpg_binary>:$PATH
export GPG_TTY=$(tty)
export TERM="xterm-256color"

neofetch
