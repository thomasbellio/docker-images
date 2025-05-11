FROM php:8.3.11
# ARG DOCKER_SOCK="/var/run/docker.sock"
ARG USER_UID=1000
ARG USER_GID=1000
ARG USER_NAME="ubuntu"
ARG DOT_FILE_CONFIG_DIR="/usr/share/thomasbell/config"
ARG SETUP_SCRIPT_DIR="/usr/share/thomasbell/setup-scripts"
# Install necessary packages
ADD dev-images/debian/install-dev-dependencies.sh .
ADD dev-images/debian/install-docker.sh .
RUN ./install-dev-dependencies.sh
RUN ./install-docker.sh

RUN mkdir -p $SETUP_SCRIPT_DIR
ADD ./dev-images/scripts/setup-user.zsh $SETUP_SCRIPT_DIR
RUN chmod +x $SETUP_SCRIPT_DIR/setup-user.zsh

RUN mkdir -p $DOT_FILE_CONFIG_DIR
ADD dev-images/config/* $DOT_FILE_CONFIG_DIR
# This will ensure the dotfile config dir is available for all usres
RUN chmod 777 $DOT_FILE_CONFIG_DIR/*

ENV PATH="$PATH:/opt/nvim-linux-x86_64/bin"
ENV SETUP_SCRIPT_DIR=$SETUP_SCRIPT_DIR
ENV DOT_FILE_CONFIG_DIR=$DOT_FILE_CONFIG_DIR

# USER $USER_NAME
# WORKDIR /home/$USER_NAME/

ADD ./dev-images/scripts/entrypoint.sh .
# SETUP THE NEOVIM PAYT FOR THE PRIMARY USER
# SETUP THE CONFIG DIR FOR THE PRIMARY USER
ENTRYPOINT ["./entrypoint.sh"]
