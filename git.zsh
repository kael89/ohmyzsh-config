alias gc="git add . && git commit"
alias gcm="gc -m"
alias gf="git fetch --prune"
alias gstash="git add . && git stash"
alias gu="git fetch && git pull"

function gcou() {
  git fetch && git checkout "$1" && git pull
}

function gre() {
  git reset HEAD~$1
}

function grho() {
  local branch=$(git branch --show-current)
  git reset --hard origin/$branch
}

function gpo() {
  local branch=$(git branch --show-current)
  git push -u origin $branch
}
