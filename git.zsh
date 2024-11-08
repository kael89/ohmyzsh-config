alias gcm='git add . && git commit -m'
alias gfoc='git fetch origin $(git branch --show-current)'
alias gfom='git fetch origin master --prune --prune-tags'
alias gpo='git push -u origin $(git branch --show-current)'
alias gprune='git prune && git remote prune origin'
alias groc='git rebase origin $(git branch --show-current)'
alias grcn='grc --no-verify'
alias gstash='git add . && git stash'
alias gu='git fetch && git pull'

function gcmn() {
  gcm "$1" --no-verify
}

function gcou() {
  git fetch && git checkout "$1" && git pull
}

function gre() {
  git reset HEAD~$1
}

# Reset latest commit, then commit using its message
# As a result, current non committed changes will be added to the last commit
# Warning: changes git history
function grc() {
  local n="$1"

  if [[ $n == "" ]]; then
    n=1
  fi
  if [[ n -le 0 ]]; then
    log_error "grc <n>: Expected positive number of commits <n>, got ${n}"
    return 1
  fi

  for ((i = 1; i <= $n; i++)); do
    commit_messages[$i]=$(git log -1 --pretty=%B)
    git reset HEAD~1 -q
    git stash
  done

  echo "Array: $commit_messages"

  for ((i = $n; i > 0; i--)); do
    git stash pop -q
    git add .
    git commit -q -m "${commit_messages[$i]}"
  done
}
