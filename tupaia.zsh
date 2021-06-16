alias ctup="cd $TUPAIA_ROOT/tupaia"
alias mgu="yarn migrate"
alias mgd="yarn migrate-down"
alias mgdu="yarn migrate-down && yarn migrate"
alias rdb="yarn dump-database $MEDITRAK_SSH_KEY && yarn refresh-database dump.sql"

function tup() {
  case $1 in
  ssh)
    shift
    tup_ssh "$@"
    ;;
  start)
    shift
    tup_start "$@"
    ;;
  *)
    echo "Usage: tup <command> [<args>]

Commands:
  ssh     SSH to an EC2 instance
  start   Start a full-stack app locally"
    return 1
    ;;
  esac
}

function tup_ssh() {
  local server=$1
  if [ "$server" = "" ]; then
    echo "Usage: tup ssh <server>"
    return 1
  fi

  sed -i.bak -e d ~/.ssh/known_hosts
  local host=ubuntu@$server.tupaia.org
  ssh -o StrictHostKeyChecking=no -i $MEDITRAK_SSH_KEY $host
}

function tup_start() {
  local app=$1

  case $1 in
  tupaia)
    cmd.exe /c \
      "wt -w 0 split-pane -H -- wsl source ~/.zshrc\; \
       cd $TUPAIA_ROOT/tupaia\; nvm -v\; \
       yarn workspace @tupaia/web-frontend start"
    cd $TUPAIA_ROOT/tupaia
    yarn workspace @tupaia/web-config-server start
    shift
    ;;
  *)
    echo "Usage: tup start tupaia"
    return 1
    ;;
  esac
}
