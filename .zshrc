#! /bin/zsh

typeset -A _consh
_consh="$HOME/.zsh"

###
# Plugins
###
source $_consh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $_consh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export CLICOLOR=1
export GPG_TTY=$(tty)
export PNPM_HOME="$HOME/.local/share/pnpm"
export GOPATH="$HOME/.go-global"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.go-global/go/bin:$PATH"
export PATH="$HOME/.go-global/bin:$PATH"
export PATH="$HOME/.act:$PATH"
export GHCR_PAT="ghp_***"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export SSH_ASKPASS=ksshaskpass
export SSH_ASKPASS_REQUIRE=prefer

alias grep='grep --color=always'
alias lsa='ls -lah --color'
alias l='ls --color'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dive="docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive"
alias oras="docker run -ti --rm -v $(pwd):/workspace ghcr.io/oras-project/oras:v1.2.0"
alias claude="$HOME/.claude/local/claude"
alias pandock="docker run --rm -v \"$(pwd):/data\" -u $(id -u):$(id -g) pandoc/extra"

autoload -Uz add-zsh-hook
autoload -Uz compinit
autoload -U colors && colors

compinit -i

setopt interactivecomments
setopt correct
setopt autocd
setopt magicequalsubst
setopt notify
setopt numericglobsort

unsetopt BEEP
unsetopt nomatch

zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:options' list-colors '=^(-- *)=34'
zstyle ':completion:*' menu select

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^H' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey -M viins '^a'    beginning-of-line
bindkey -M viins '^e'    end-of-line
bindkey -M viins '^k'    kill-line
bindkey -M viins '^w'    backward-kill-word
bindkey -M viins '^u'    backward-kill-line
zle -N edit-command-line
bindkey -M viins '^xe'  edit-command-line
bindkey -M viins '^x^e'  edit-command-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

HISTFILE=$HOME/.zsh_history       # enable history saving on shell exit
setopt SHARE_HISTORY           # share history between sessions
HISTSIZE=10000                  # lines of history to maintain memory
SAVEHIST=1000                  # lines of history to maintain in history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "/home/lanhild/.bun/_bun" ] && source "/home/lanhild/.bun/_bun"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
eval "$(starship init zsh)"
