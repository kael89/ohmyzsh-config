alias gc="git add . && git commit"
alias gcm="gc -m"
alias gstash="git add . && git stash"
alias gu="git fetch && git pull"

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
  local last_commit_message=$(git log -1 --pretty=%B)

  gre
  gcm "$last_commit_message"
}

function grho() {
  local branch=$(git branch --show-current)
  git reset --hard origin/$branch
}

function gpo() {
  local branch=$(git branch --show-current)
  git push -u origin $branch
}
