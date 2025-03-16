#!/bin/bash
set -e # stop on errors
echo "Bootstrapping the shell environment for root...."
sudo -u root DOT_FILE_CONFIG_DIR="$DOT_FILE_CONFIG_DIR" /bin/zsh $DOT_FILE_CONFIG_DIR/bootstrap.zsh
echo "Bootstrapped the shell environment for root"
echo "Bootstrapping the shell environment for $USER_NAME"
/bin/zsh $DOT_FILE_CONFIG_DIR/bootstrap.zsh
echo "Bootstrapped the environment."
echo "Changing directory to $HOME_DIR"
echo "executing command: '$@'...."
"$@"

