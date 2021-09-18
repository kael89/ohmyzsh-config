source "$ZSH/custom/utils.sh"

alias dus="du -sh * | sort -h"
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

function wsp() {
  local JS_PROJECT_PATH="$(echo ~)/projects/javascript"
  local TAMANU_PATH="$(echo ~)/bes/Tamanu/tamanu"
  local TUPAIA_PATH="$(echo ~)/bes/Tupaia/tupaia"

  if [ "$#" -lt 1 ]; then
    log_error "Please provide a workspace!"
    return 1
  fi

  local workspace
  if [[ $(pwd) =~ $JS_PROJECT_PATH ]]; then
    local project=$(command pwd | sed "s|$JS_PROJECT_PATH/||" | sed 's|/.*||')
    workspace="@${project}/$*"
  elif [[ $(pwd) =~ $TUPAIA_PATH ]]; then
    workspace="@tupaia/$*"
  elif [[ $(pwd) =~ $TAMANU_PATH ]]; then
    workspace="$*"
  else
    workspace="@tupaia/$*"
    run "cd $TUPAIA_PATH"
  fi

  run "yarn workspace $workspace"
}
