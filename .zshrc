#! /bin/zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -A _consh
_consh="$HOME/.zsh"

###
# Plugins
###
source $_consh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $_consh/plugins/zsh-histdb/sqlite-history.zsh
source $_consh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $_consh/plugins/powerlevel10k/powerlevel10k.zsh-theme
###

export CLICOLOR=1
export GPG_TTY=$(tty)
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH=~/.npm-global/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export NPM_TOKEN="npm_***"

alias grep='grep --color=always'
alias lsa='ls -lah --color'
alias l='ls --color'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

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
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey -M viins '^a'    beginning-of-line
bindkey -M viins '^e'    end-of-line
bindkey -M viins '^k'    kill-line
bindkey -M viins '^w'    backward-kill-word
bindkey -M viins '^u'    backward-kill-line
zle -N edit-command-line
bindkey -M viins '^xe'  edit-command-line
bindkey -M viins '^x^e'  edit-command-line

HISTFILE=$HOME/.zsh_history       # enable history saving on shell exit
setopt SHARE_HISTORY           # share history between sessions
HISTSIZE=10000                  # lines of history to maintain memory
SAVEHIST=1000                  # lines of history to maintain in history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information

