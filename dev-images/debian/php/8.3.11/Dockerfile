FROM php:8.3.11
ARG USER_UID=1000
ARG USER_GID=1000
ARG USER_NAME="ubuntu"
ARG DOT_FILE_CONFIG_DIR="/usr/share/thomasbell/config"
# Install necessary packages
ADD dev-images/debian/install-dev-dependencies.sh .
ADD dev-images/debian/install-docker.sh .
RUN ./install-dev-dependencies.sh
RUN ./install-docker.sh

ADD ./dev-images/scripts/setup-user.sh .
RUN ./setup-user.sh

RUN mkdir -p $DOT_FILE_CONFIG_DIR
ADD dev-images/config/* $DOT_FILE_CONFIG_DIR
RUN chmod 777 $DOT_FILE_CONFIG_DIR/*

USER $USER_NAME
WORKDIR /home/$USER_NAME/

ADD ./dev-images/scripts/entrypoint.sh .
# SETUP THE NEOVIM PAYT FOR THE PRIMARY USER
ENV PATH="$PATH:/opt/nvim-linux-x86_64/bin"
# SETUP THE CONFIG DIR FOR THE PRIMARY USER
ENV DOT_FILE_CONFIG_DIR=$DOT_FILE_CONFIG_DIR
ENTRYPOINT ["./entrypoint.sh"]
