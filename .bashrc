#!/usr/bin/env bash

# git pull branch by merging
# can be used by:
#   gpb                   -> merges origin/master to current branch
#   gpb develop           -> merges origin/develop to current branch
#   gpb develop upstream  -> merges upstream/develop to current branch
gpb() {
  # process:
  # git checkout master
  # git pull origin master
  # git checkout currBranch
  # git merge master

  if [ -d .git ]; then
    currBranch=$(git rev-parse --abbrev-ref HEAD);
    remote=${2:-"origin"}
    branch=${1:-"master"}

    if [ "$branch" != "$currBranch" ]; then
      git checkout "$branch";
      git fetch --prune
      git pull "$remote" "$branch";
      echo ""
      echo "pulled from $remote $branch"
      echo ""
      git checkout "$currBranch";
      git merge "$branch"
      echo ""
      echo "merged $branch to $currBranch"
    else
      echo "already on the same branch, pulling from $2"
      git pull "$remote" "$branch";
    fi
  else
    echo "not a git repository"
  fi;
}

# git pull branch by rebase
# similar to above but uses rebase instead of merge
gpbr() {
  if [ -d .git ]; then
    currBranch=$(git rev-parse --abbrev-ref HEAD);
    remote=${2:-"origin"}
    branch=${1:-"master"}

    if [ "$branch" != "$currBranch" ]; then
      git checkout "$branch";
      git fetch --prune
      git pull "$remote" "$branch";
      echo ""
      echo "pulled from $remote $branch"
      echo ""
      git checkout "$currBranch";
      git rebase "$branch"
      echo ""
      echo "rebased $branch to $currBranch"
    else
      echo "already on the same branch, pulling from $2"
      git pull "$remote" "$branch";
    fi
  else
    echo "not a git repository"
  fi;
}

# aliases for interchangeable characters of 2 functions above
alias gbp=gpb
alias gbpr=gpbr

# docker aliases
alias dcu='docker-compose up -d'
alias dce='docker-compose exec'
alias dcr='docker-compose run --rm'
alias dc='docker-compose'

# other aliases
alias gitex=gitex.cmd
alias gx=gitex
alias rebash='source ~/.bash_profile'
alias refresh='source ~/.bash_profile'