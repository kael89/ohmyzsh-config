alias ls='ls -a'
alias port='lsof -i -P -n | grep'
alias rmf='rm -rf'
alias src='exec zsh'

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

# Show swap memory stats
function swap() {
  sysctl vm.swapusage | awk '{printf "total = %.0fGB\n used = %.0fGB\n", $4 / 1024, $7 / 1024}'
}

function timezsh() {
  local count=${1:-5}

  for i in $(seq 1 $count); do time $SHELL -i -c exit; done
}
