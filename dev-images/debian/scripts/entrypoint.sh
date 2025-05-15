#!/bin/zsh
set -e # stop on errors
export USER_UID=${USER_UID:-1000}
export USER_GID=${USER_GID:-1000}
export USER_NAME=${USER_NAME:-DEFAULT_DEV_USER}

export GROUP_NAME=${GROUP_NAME:-$USER_NAME}
export DOCKER_SOCKET=${DOCKER_SOCK:-"/var/run/docker.sock"}

if [ ! -f "setup-user.log" ]; then
       ./scripts/setup-user.sh | tee setup-user.log
fi
cd /home/$USER_NAME
if [ ! -f "dev-image-bootstrap.log" ]; then
    echo "Bootstrapping the shell environment for $USER_NAME"
    sudo -u $USER_NAME -i -H  $SETUP_SCRIPT_DIR/scripts/dotfiles.zsh | tee dev-image-bootstrap.log
    echo "Bootstrapped the environment."
fi
echo "starting container with user $USER_NAME and docker socket $DOCKER_SOCK"
echo "executing command: '$@'...."
exec sudo -i -u $USER_NAME -H env DISPLAY="$DISPLAY" "$@"
#
