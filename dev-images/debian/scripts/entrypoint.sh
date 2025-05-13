#!/bin/zsh
set -e # stop on errors
# GROUP_NAME=${GROUP_NAME:-$USER_NAME} \
# Get Docker GID from the socket or use default

export DOT_FILES_DIR=${DOT_FILES_DIR}
export SETUP_SCRIPT_DIR=${SETUP_SCRIPT_DIR}
export USER_UID=${USER_UID:-1000}
export USER_GID=${USER_GID:-1000}
export USER_NAME=${USER_NAME:-'devel'}
export GROUP_NAME=${GROUP_NAME:-$USER_NAME}
export DOCKER_SOCKET=${DOCKER_SOCK:-"/var/run/docker.sock"}

if [ ! -f "setup-user.log" ]; then
       ./scripts/setup-user.sh | tee setup-user.log
fi
echo "Changing directory to /home/$USER_NAME"
cd /home/$USER_NAME
if [ ! -f "dev-image-bootstrap.log" ]; then
    echo "Bootstrapping the shell environment for $USER_NAME"
    sudo -u $USER_NAME -H env DISPLAY="$DISPLAY" OPENAI_API_KEY="$OPENAI_API_KEY" DOT_FILES_DIR="$DOT_FILES_DIR" $SETUP_SCRIPT_DIR/scripts/dotfiles.zsh | tee dev-image-bootstrap.log
    echo "Bootstrapped the environment."
fi
echo "starting container with user $USER_NAME and docker socket $DOCKER_SOCK"
echo "executing command: '$@'...."
exec sudo -i -u $USER_NAME -H env DISPLAY="$DISPLAY" OPENAI_API_KEY="$OPENAI_API_KEY" ZSH_FEATURE_DEBUG="$ZSH_FEATURE_DEBUG" "$@"

