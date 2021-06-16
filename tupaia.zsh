alias ctup="cd $TUPAIA_ROOT/tupaia"
alias mgu="yarn migrate"
alias mgd="yarn migrate-down"
alias mgdu="yarn migrate-down && yarn migrate"
alias rdb="yarn dump-database $MEDITRAK_SSH_KEY && yarn refresh-database dump.sql"

function tssh() {
  local usage="Usage: tssh \$server"

  local server=$1
  if [ "$server" = "" ]; then
    echo $usage
    return 1
  fi

  sed -i.bak -e d ~/.ssh/known_hosts
  local host=ubuntu@$server.tupaia.org
  ssh -o StrictHostKeyChecking=no -i $MEDITRAK_SSH_KEY $host
}
