FROM debian:bookworm-slim
# This is the directory that contains all the setup scripts for our dev docker images
ARG SETUP_SCRIPT_DIR="/usr/share/thomasbell/setup-scripts"
ARG DOT_FILES_DIR="/usr/share/thomasbell/dotfiles"
ENV SETUP_SCRIPT_DIR=$SETUP_SCRIPT_DIR
ENV DOT_FILES_DIR=$DOT_FILES_DIR
ADD . $SETUP_SCRIPT_DIR
WORKDIR $SETUP_SCRIPT_DIR
ADD dev-images/environment/zshenv /etc/zsh/zshenv
RUN chmod +x dev-images/bootstrap/dotfiles.sh && \
    chmod +x -R dev-images/debian/scripts/*.sh
RUN ./dev-images/debian/scripts/install-dev-dependencies.sh | tee $HOME/dev-image-install.log
RUN DOT_FILES_DIR=$DOT_FILES_DIR ./dev-images/debian/bootstrap/dotfiles.sh | tee --append $HOME/dev-image-bootstrap.log
# RUN chmod 777 $DOT_FILES_DIR && \
#     chmod 777 $DOT_FILES_DIR/* # ensure all users can access the dot files
ADD ./dev-images/debian/scripts/entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
