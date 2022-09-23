source "$ZSH_CUSTOM/utils.sh"

alias dus="du -hs .* * --total 2> >(grep -v '^du: cannot access' >&2) | sort -h"
alias gacd="gatsby clean && gatsby develop"
alias gad="gatsby develop"
alias inst="apt list --installed | grep"
alias ls="ls -a"
alias port="lsof -i -P -n | grep"
alias rmf="rm -rf"
alias src="source ~/.zshrc && source $ZSH_CUSTOM/*.zsh"

function copy() {
  eval "$@" | clip.exe
}

function lsg() {
  if [[ "$#" > 1 ]]; then
    location="$1"
    search="$2"
  else
    location="."
    search="$1"
  fi

  ls -a "$location" | grep -i "$search"
}
