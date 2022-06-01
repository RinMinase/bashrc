#!/usr/bin/env bash

# git pull branch by merging
gpb() {
  # defaults to master

  # gpb
  # gpb develop
  # gpb develop upstream

  # git checkout master
  # git pull origin master
  # git checkout currBranch
  # git merge master

  # if [ -z ${1+x} ] && [ -z ${2+x} ] then
  #   echo "var is unset";
  # else
  #    echo "var is set to '$1'"
  # fi

  if [ -d .git ]; then
    currBranch=$(git rev-parse --abbrev-ref HEAD);
    remote=${2:-"origin"}
    branch=${1:-"master"}

    # echo "test $remote $branch";

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
gpbr() {
  if [ -d .git ]; then
    currBranch=$(git rev-parse --abbrev-ref HEAD);
    remote=${2:-"origin"}
    branch=${1:-"master"}

    # echo "test $remote $branch";

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

alias gbp=gpb
alias gbpr=gpbr

alias gitex=gitex.cmd
alias gx=gitex
alias rebash='source ~/.bash_profile'