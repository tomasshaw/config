# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/$USER/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git nvm thefuck gh docker docker-compose macos zsh-autosuggestions zsh-syntax-highlighting )

source $ZSH/oh-my-zsh.sh
# source /usr/share/doc/fzf/examples/completion.zsh
# source /usr/share/doc/fzf/examples/key-bindings.zsh

# User configuration

# fd arch / fdfind ubuntu - fedora
# export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='nvim'
#export BROWSER='google-chrome-stable'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim"
alias ls="exa --long --header -a"
#alias ls="exa --long --header --git -a"
alias mv="mv -iv"
alias cp="cp -riv"
alias ccc="xclip -sel clip"
alias s="grep -nHriI --exclude-dir={.git,node_modules,build}"
alias mkcd="mkdirAndCd"
alias mkdir="mkdir -vp"
alias gpa="git_pull_recursive"
alias b="set_brightness"
alias b1="set_brightness_2"
alias b2="set_brightness_1"
alias ba="get_brightness"
alias cd="z"

# eval $(thefuck --alias)
eval "$(zoxide init zsh)"

mkdirAndCd () {
    mkdir -vp -- "$1" &&
      cd -P -- "$1"
}

set_brightness () {
	ddcutil setvcp 10 $1 --display 1
	ddcutil setvcp 10 $1 --display 2
	ddcutil setvcp 10 $1 --display 3
}
set_brightness_1 () {
	ddcutil setvcp 10 $1 --display 1
}
set_brightness_2 () {
	ddcutil setvcp 10 $1 --display 2
}
set_brightness_3 () {
	ddcutil setvcp 10 $1 --display 3
}
get_brightness () {
	ddcutil getvcp 10 --display 1
	ddcutil getvcp 10 --display 2
	ddcutil getvcp 10 --display 3
}
#VimOpenAll
voa () {
	nvim -p ${1:-.}/**/*(.)
}
replace () {
	grep -rl $1 . --exclude-dir=.git | xargs sed -i "s/$1/$2/g"
}
git_pull_recursive () {
	find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;
}
# Search a file with fzf inside a Tmux pane and then open it in an editor
fzf_then_open_in_editor() {
  local file=$(fzf-tmux)
  # Open the file if it exists
  if [ -n "$file" ]; then
    # Use the default editor if it's defined, otherwise Vim
    ${EDITOR:-vim} "$file"
  fi
}
docker_erase_all () {
	docker rm $(docker ps -aq)
}
docker_stop_all () {
	docker stop $(docker ps -q)
}
ip_curr () {
	hostname -I | awk '{print $1}'
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zle -C fzf_then_open_in_editor
# bindkey '\C-t' fzf_then_open_in_editor
bindkey -s '\C-t' 'fzf_then_open_in_editor^M'

# Gift from Pablo :)
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[k' up-line-or-beginning-search
bindkey '^[j' down-line-or-beginning-search

FZF_DEFAULT_OPTS="
	--bind tab:toggle-out,shift-tab:toggle-in\
	--bind alt-j:down,alt-k:up,ctrl-j:preview-down,ctrl-k:preview-up\
	--color=dark\
	--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f\
	--color=info:#7aa6da,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
