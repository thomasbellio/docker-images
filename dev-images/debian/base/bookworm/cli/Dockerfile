FROM debian:bookworm-slim
# ARG DOT_FILE_CONFIG_DIR="/usr/share/thomasbell/config"
# ARG SETUP_SCRIPT_DIR="/usr/share/thomasbell/setup-scripts"
# ARG ZSH_FEATURE_DEBUG=0
# # Install necessary packages
# ADD dev-images/debian/install-dev-dependencies.sh .
# ADD dev-images/debian/install-docker.sh .
# RUN ./install-dev-dependencies.sh
# RUN ./install-docker.sh
#
# RUN mkdir -p $SETUP_SCRIPT_DIR
# ADD ./dev-images/debian/scripts/setup-user.zsh $SETUP_SCRIPT_DIR
# RUN chmod +x $SETUP_SCRIPT_DIR/setup-user.zsh
#
# RUN mkdir -p $DOT_FILE_CONFIG_DIR
# ADD dev-images/config/* $DOT_FILE_CONFIG_DIR
# # This will ensure the dotfile config dir is available for all usres
# RUN chmod 777 $DOT_FILE_CONFIG_DIR/*
#
# # ENV PATH="$PATH:/opt/nvim-linux-x86_64/bin"
# ENV SETUP_SCRIPT_DIR=$SETUP_SCRIPT_DIR
# ENV DOT_FILE_CONFIG_DIR=$DOT_FILE_CONFIG_DIR
# ENV ZSH_FEATURE_DEBUG=$ZSH_FEATURE_DEBUG
# ADD ./dev-images/debian/scripts/entrypoint.sh .
# ENTRYPOINT ["./entrypoint.sh"]
