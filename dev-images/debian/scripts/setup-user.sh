#!/usr/bin/bash
set -e # stop on errors

if [ ! -f "$SETUP_SCRIPT_DIR/bootstrapped-user.txt" ]; then
    if [ -z "$DOCKER_GID" ]; then
        if [ -e "$DOCKER_SOCKET" ]; then
            DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET")
        else
            DOCKER_GID=998  # Common default, but might vary
        fi
    fi

    echo "Starting with USER_UID: $USER_UID, GID: $USER_GID, USERNAME: $USER_NAME, GROUPNAME: $GROUP_NAME, DOCKER_SOCKET: ${DOCKER_SOCKET}, DOCKER_GID: ${DOCKER_GID}"

    HOME_DIR="/home/$USER_NAME"
    echo "Using HOMEDIR: $HOME_DIR"

    # Check if the group already exists
    if id -g $USER_GID > /dev/null 2>&1; then
        # Get the existing username with this UID
        EXISTING_GROUP=$(id -ng $USER_GID)
        echo "Group with UID $USER_GID already exists: $EXISTING_GROUP"
        if [ "$EXISTING_GROUP" == "root" ]; then
            echo "You cannot use a group id that corresponds to root user. $USER_GID is not valid, use a different id."
            exit 1
        fi
        if [ "$EXISTING_GROUP" != "$GROUP_NAME" ]; then
            groupmod -n $GROUP_NAME $EXISTING_GROUP
        fi
    else
        echo "Creating $GROUP_NAME group with UID $USER_GID..."
        groupadd -g $USER_GID $GROUP_NAME
    fi

    # Check if user with this UID already exists
    if id -u $USER_UID > /dev/null 2>&1; then
        # Get the existing username with this UID
        EXISTING_USER=$(id -nu $USER_UID)
        echo "User with UID $USER_UID already exists: $EXISTING_USER"
        # Create symbolic links for our expected paths
        if [ "$EXISTING_USER" == "root" ]; then
            echo "You cannot use a user id that corresponds to root user. $USER_UID is not valid, use a different id."
            exit 1
        fi
        if [ "$EXISTING_USER" != "$USER_NAME" ]; then
            # Ensure home directory exists
            echo "Renaming existing user: $EXISTING_USER to $USER_NAME"
            usermod -l $USER_NAME $EXISTING_USER
            if [ ! -d "$HOME_DIR" ] || [ "$(stat -c '%U' "$HOME_DIR")" != "$USER_NAME" ]; then
                # Create directory if it doesn't exist
                [ ! -d "$HOME_DIR" ] && echo "Creating the home dir: $HOME_DIR..." && \
                    mkdir -p "$HOME_DIR"
                # Change ownership if needed
                chown -R "$USER_NAME:$(id -gn "$USER_NAME")" "$HOME_DIR"
                # Update user's home directory in /etc/passwd
                usermod -d "$HOME_DIR" "$USER_NAME"
            else
                echo "Home directory $HOME_DIR already exists...."
            fi
        fi
    else
        echo "Creating $USER_NAME user with UID $USER_UID..."
        useradd -m -u $USER_UID -g $GROUP_NAME -s $(which zsh) $USER_NAME
    fi
    chown -R "$USER_NAME:$(id -gn "$USER_NAME")" "$HOME_DIR"
    # Check if the sudoers file for the user already exists
    if [ ! -f "/etc/sudoers.d/$USER_NAME" ]; then
        echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME
        chmod 0440 /etc/sudoers.d/$USER_NAME
        echo "Added $USER_NAME to sudoers"
    else
        echo "Sudoers entry for $USER_NAME already exists"
    fi


    echo "Setting up docker group with GID: $DOCKER_GID"

    # Create the docker group with the right GID
    if getent group docker > /dev/null 2>&1; then
        # If docker group exists, update its GID
        groupmod -g $DOCKER_GID docker
    else
        # Create the docker group with the right GID
        groupadd -g $DOCKER_GID docker
    fi

    # Add user to the docker group
    usermod -aG docker $USER_NAME
    echo "Added $USER_NAME to the docker group"
    echo "USER_NAME=$USER_NAME" > "$SETUP_SCRIPT_DIR/bootstrapped-user.txt"
    echo "USER_UID=$USER_UID" >> "$SETUP_SCRIPT_DIR/bootstrapped-user.txt"
    echo "GROUP_NAME=$GROUP_NAME" >> "$SETUP_SCRIPT_DIR/bootstrapped-user.txt"
    echo "DOCKER_SOCKET=$DOCKER_SOCKET" >> "$SETUP_SCRIPT_DIR/bootstrapped-user.txt"
    echo "DOCKER_GID=$DOCKER_GID" >> "$SETUP_SCRIPT_DIR/bootstrapped-user.txt"
    chmod 777 "$SETUP_SCRIPT_DIR/bootstrapped-user.txt"
fi

