alias gc="git add . && git commit"
alias gcm="git add . && git commit -m"
alias gprune="git prune && git remote prune origin"
alias grcn="grc --no-verify"
alias grbm="git rebase origin/master"
alias gstash="git add . && git stash"
alias gu="git fetch && git pull"

function gclone() {
  local repo="$1"

  if [[ $PROJECT_ROOT_PERSONAL == "" ]]; then
    log_error "Please set PROJECT_ROOT_PERSONAL"
    return 1
  fi

  git clone "$GIT_HOME_URL/$repo" "$PROJECT_ROOT_PERSONAL/$repo"
}

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

function gpo() {
  local branch=$(git branch --show-current)
  git push -u origin $branch
}
