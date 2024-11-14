#!/bin/bash
set -e

funciton main {
  install_git_hooks
}

function install_git_hooks {
  echo "Installing git hooks..."
  redirect_hooks_location
  echo "Git hooks installed."
}

function redirect_hooks_location {
  # Default location for git hooks is .git/hooks
  git config core.hooksPath scripts/git-hooks
}

main