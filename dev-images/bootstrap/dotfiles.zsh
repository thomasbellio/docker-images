#!/usr/bin/zsh

function cloneRepo() {
    local repoName=$1
    local targetDir=$2
    # # Check if the directory already exists
    if [ ! -d "$targetDir" ]; then
      echo "cloning $repoName to $targetDir"
      git clone $repoName "$targetDir"
    else
      echo "Repository already exists at $targetDir"
    fi
}

cloneRepo "https://github.com/thomasbellio/mydotfiles.git" $DOTFILES_DIR

ln -s  $DOTFILES_DIR/zsh/zshrc ~/.zshrc

