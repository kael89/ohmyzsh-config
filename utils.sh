ANSI_COLOR_BLACK="\033[30m"
ANSI_COLOR_RED="\033[31m"
ANSI_COLOR_GREEN="\033[32m"
ANSI_COLOR_YELLOW="\033[33m"
ANSI_COLOR_BLUE="\033[34m"
ANSI_COLOR_MAGENTA="\033[35m"
ANSI_COLOR_CYAN="\033[36m"
ANSI_COLOR_WHITE="\033[37m"
ANSI_COLOR_RESET="\033[0m"

ANSI_EFFECT_DIM="\033[2m"

function log_colored() {
  local message=$1
  local color=$2

  echo "${color}${message}${ANSI_COLOR_RESET}"
}

function log_success() {
  log_colored "$1" $ANSI_COLOR_GREEN
}

function log_error() {
  log_colored "$1" $ANSI_COLOR_RED
}

function log_verbose() {
  log_colored "$1" "${ANSI_EFFECT_DIM}${ANSI_COLOR_GRAY}"
}

function run() {
  log_verbose "$1"
  eval "$1"
}
