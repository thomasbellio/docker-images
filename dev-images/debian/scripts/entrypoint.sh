#!/bin/zsh
set -e # stop on errors
# GROUP_NAME=${GROUP_NAME:-$USER_NAME} \
# Get Docker GID from the socket or use default


if [ ! -f "$SETUP_SCRIPT_DIR/provision-system.log" ]; then
    chmod +x $SETUP_SCRIPT_DIR/provision-system.zsh
    USER_UID=${USER_UID:-1000} \
    USER_GID=${USER_GID:-1000} \
    USER_NAME=${USER_NAME:-'devel'} \
    GROUP_NAME=${GROUP_NAME:-$USER_NAME} \
    DOCKER_SOCKET=${DOCKER_SOCK:-"/var/run/docker.sock"} \
    /usr/bin/zsh $SETUP_SCRIPT_DIR/provision-system.zsh | tee $SETUP_SCRIPT_DIR/provision-system.log
fi
echo "GOT A DEBUG VALUE: $ZSH_FEATURE_DEBUG"
echo "Bootstrapping the shell environment for root...."
OPENAI_API_KEY="$OPENAI_API_KEY" USER_ID="$USER_UID" USER_GID="$USER_GID" DOT_FILE_CONFIG_DIR="$DOT_FILE_CONFIG_DIR" .$DOT_FILE_CONFIG_DIR/bootstrap.zsh
echo "Bootstrapped the shell environment for root"
echo "Bootstrapping the shell environment for $USER_NAME"
sudo -u $USER_NAME -H env DISPLAY="$DISPLAY" OPENAI_API_KEY="$OPENAI_API_KEY" DOT_FILE_CONFIG_DIR="$DOT_FILE_CONFIG_DIR" $DOT_FILE_CONFIG_DIR/bootstrap.zsh
echo "Bootstrapped the environment."
echo "Changing directory to /home/$USER_NAME"
cd /home/$USER_NAME
echo "starting container with user $USER_NAME and docker socket $DOCKER_SOCK"
echo "executing command: '$@'...."
exec sudo -i -u $USER_NAME -H env DISPLAY="$DISPLAY" OPENAI_API_KEY="$OPENAI_API_KEY" ZSH_FEATURE_DEBUG="$ZSH_FEATURE_DEBUG" "$@"

