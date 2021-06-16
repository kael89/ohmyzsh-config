ANSI_COLOR_DEFAULT="\033[0m"
ANSI_COLOR_GREEN="\033[32m"
ANSI_COLOR_RED="\033[31m"

function log_colored() {
  local message=$1
  local color=$2

  echo "${color}${message}${ANSI_COLOR_DEFAULT}"
}

function log_success() {
  log_colored "$1" $ANSI_COLOR_GREEN
}

function log_error() {
  log_colored "$1" $ANSI_COLOR_RED
}

function run() {
  log_success "$1"
  eval "$1"
}
