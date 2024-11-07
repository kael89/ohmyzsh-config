function prj() {
  local USAGE="Usage: prj [project package]"

  if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo $USAGE
    return
  fi

  local project="$1"
  local package="$2"

  if [[ "$project" = "" ]]; then
    run "cd $PROJECT_ROOT_PERSONAL/$project" || return 1
    return
  fi

  if [[ $package == "" ]]; then
    run "cd $PROJECT_ROOT_PERSONAL/$project" || return 1
  else
    shift
    run "cd $PROJECT_ROOT_PERSONAL/$project/packages/$package" || return 1
  fi
}

function wsp() {
  local USAGE="Usage: wsp <workspace> [command] [args...]

Unless if specified otherwise, the script will run the specified command
with its args from the current directory.

If no command is provided, then the script will cd in <workspace>.
"

  local workspace="$1"

  if [[ "$workspace" == "" ]]; then
    echo $USAGE
    return 1
  fi

  if [[ $2 == "" ]]; then
    run "cd packages/$workspace" || return 1
  else
    shift
    run "(cd packages/$workspace && yarn $*)" || return 1
  fi
}
