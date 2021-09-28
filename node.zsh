# Node package and repository utils
function np() {
  case $1 in
  clean)
    shift
    _np_clean "$@"
    ;;
  find)
    shift
    _np_find "$@"
    ;;
  *)
    echo "Usage: np <command> [<args>]

Commands:
  clean   Clean up the repo (delete node_modules etc)
  find    Find a file"
    return 1
    ;;
  esac
}

function _np_clean() {
  rm -rf node_modules

  if [[ -d packages ]]; then
    # Monorepo, clean workspaces
    for f in packages/*; do
      rm -rf "$f/node_modules"
    done
  fi
}

function _np_find() {
  local USAGE="Usage: np find [options...] <name>

Options:
  -p, --path        Path to search in (default: .)
  -r, --regex       Use regex
  -h, --help        Show help
"

  local path="."
  local search_op="-name"
  local name=""

  while [ "$1" != "" ]; do
    case $1 in
    -p | --path)
      shift
      path="$1"
      ;;
    -r | --regex)
      shift
      search_op="-regex"
      ;;
    -h | --help)
      echo "$USAGE"
      return
      ;;
    *)
      name=$1
      shift
      ;;
    esac
  done

  if [[ $name == "" ]]; then
    echo "$USAGE"
    return 1
  fi

  find "$path" -path "*/node_modules" -prune , -path "*/dist" -prune , -type f $search_op "$name" | sort
}

function wsp() {
  local USAGE="Usage: wsp <workspace> [options...] [command] [args...]

Unless if specified otherwise, the script will run the specified command
with its args from the current directory.

If no options and args are provided, then the script will cd in <workspace>.

Options:
  -s                Will cd in <workspace> and run \"start\". Ignores command and args
  -sd               Will cd in <workspace> and run \"start-dev\". Ignores command and args
  -h, --help        Show help

Usage examples:
  wsp meditrak-server
  wsp meditrak-server -s
  wsp meditrak-server test --coverage
"

  local workspace="$1"

  if [[ "$workspace" == "" ]]; then
    echo $USAGE
    return 1
  fi

  local project_path=""
  if [[ $(pwd) =~ $JS_PROJECT_ROOT ]]; then
    local project=$(command pwd | sed "s|$JS_PROJECT_ROOT/||" | sed 's|/.*||')
    project_path="$JS_PROJECT_ROOT/$project"
  elif [[ $(pwd) =~ $TUPAIA_ROOT ]]; then
    local project=$(command pwd | sed "s|$TUPAIA_ROOT/||" | sed 's|/.*||')
    project_path="$TUPAIA_ROOT/$project"
  elif [[ $(pwd) =~ $TAMANU_ROOT ]]; then
    local project=$(command pwd | sed "s|$TAMANU_ROOT/||" | sed 's|/.*||')
    project_path="$TAMANU_ROOT/$project"
  else
    project_path="$TUPAIA_ROOT/tupaia/$project"
  fi

  if [[ $2 == "" ]]; then
    run "cd $project_path/packages/$workspace"
  elif [[ $2 == "-s" ]]; then
    run "(cd $project_path/packages/$workspace && yarn start)"
  elif [[ $2 == "-sd" ]]; then
    run "(cd $project_path/packages/$workspace && yarn start-dev)"
  else
    shift
    run "(cd $project_path/packages/$workspace && yarn $*)"
  fi
}
