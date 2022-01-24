source "$ZSH/custom/utils.sh"

alias ctup="cd $TUPAIA_ROOT/tupaia"
alias ctup2="cd $TUPAIA_ROOT/tupaia2"
alias mgu="yarn migrate"
alias mgd="yarn migrate-down"
alias mgdu="yarn migrate-down && yarn migrate"
alias tap="wsp admin-panel"
alias taps="wsp admin-panel-server"
alias tda="wsp data-api"
alias tdb="wsp database"
alias tes="wsp entity-server"
alias tms="wsp meditrak-server"
alias trs="wsp report-server"
alias twc="wsp web-config-server"
alias twf="wsp web-frontend"

# @param1: A path - can be a subpath of a tupaia project or not
# @returns The root path for the specified tupaia project subpath.
#   If the subpath is not under a tupaia project, defaults to "$TUPAIA_ROOT/tupaia"
#
# Examples
# --------
# $TUPAIA_ROOT/tupaia => $TUPAIA_ROOT/tupaia
# $TUPAIA_ROOT/tupaia2 => $TUPAIA_ROOT/tupaia2
# $TUPAIA_ROOT/tupaia2/a/sub/path => $TUPAIA_ROOT/tupaia2
# /non/tupaia/path => $TUPAIA_ROOT/tupaia
function _get_tupaia_project_root() {
  local root_folder=$(echo $1 | sed -rn "s|.*$TUPAIA_ROOT/?([^/]*)/?.*|\1|p")
  if [[ $root_folder == "" ]]; then
    root_folder="tupaia"
  fi

  echo "$TUPAIA_ROOT/$root_folder"
}

function tup_wsp() {
  local workspace=$1
  local project_root=$(_get_tupaia_project_root $(pwd))

  run "cd $project_root/packages/$workspace"

  if [[ $2 == "" ]]; then
    return
  elif [[ $2 == "-s" ]]; then
    run "yarn start"
  else
    shift
    run "yarn $*"
  fi
}

function tup() {
  case $1 in
  rdb)
    shift
    _tup_rdb "$@"
    ;;
  ssh)
    shift
    _tup_ssh "$@"
    ;;
  start)
    shift
    _tup_start "$@"
    ;;
  *)
    echo "Usage: tup <command> [args]

Commands:
  rdb     Dump and refresh the database
  ssh     SSH to an EC2 instance
  start   Start a full-stack app locally"
    return 1
    ;;
  esac
}

function _tup_rdb() {
  yarn dump-database $MEDITRAK_SSH_KEY "$@"
  yarn refresh-database dump.sql
}

function _tup_ssh() {
  local server=$1
  if [ "$server" = "" ]; then
    echo "Usage: tup ssh <server>"
    return 1
  fi

  sed -i.bak -e d ~/.ssh/known_hosts
  local host=ubuntu@$server.tupaia.org
  ssh -o StrictHostKeyChecking=no -i $MEDITRAK_SSH_KEY $host
}

function _tup_start() {
  local app=$1

  case $1 in
  tupaia)
    cmd.exe /c \
      "wt -w 0 wsl.exe . $NVM_DIR/nvm.sh\; \
       cd $TUPAIA_ROOT/tupaia\; \
       yarn workspace @tupaia/web-config-server start"
    cmd.exe /c \
      "wt -w 0 split-pane -H wsl.exe . $NVM_DIR/nvm.sh\; \
       cd $TUPAIA_ROOT/tupaia\; \
       yarn workspace @tupaia/web-frontend start"
    ;;
  *)
    echo "Usage: tup start tupaia"
    return 1
    ;;
  esac
}
