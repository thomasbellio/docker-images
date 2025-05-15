FROM debian:bookworm-slim
SHELL ["/usr/bin/bash", "-c"]
ARG SETUP_SCRIPT_DIR="/usr/share/thomasbellio/setup-scripts"
ARG DOTFILES_DIR="/usr/share/thomasbellio/dotfiles"

ENV SETUP_SCRIPT_DIR=$SETUP_SCRIPT_DIR
ENV DOTFILES_DIR=$DOTFILES_DIR

RUN mkdir -p $SETUP_SCRIPT_DIR/scripts

WORKDIR $SETUP_SCRIPT_DIR

ADD dev-images/debian/scripts/install-dev-dependencies.sh scripts/install-dev-dependencies.sh
ADD dev-images/debian/scripts/install-docker.sh scripts/install-docker.sh
ADD dev-images/debian/scripts/setup-user.sh scripts/setup-user.sh

RUN  chmod +x -R scripts/*.sh
RUN ./scripts/install-dev-dependencies.sh | tee -a $HOME/dev-image-install.log && test ${PIPESTATUS[0]} -eq 0
RUN ./scripts/install-docker.sh | tee -a $HOME/dev-image-install.log && test ${PIPESTATUS[0]} -eq 0


ADD dev-images/bootstrap/dotfiles.zsh scripts/dotfiles.zsh
RUN chmod +x scripts/dotfiles.zsh
RUN DOTFILES_DIR=$DOTFILES_DIR ./scripts/dotfiles.zsh | tee --append $HOME/dev-image-bootstrap.log

RUN chmod 777 $DOTFILES_DIR && \
     chmod 777 $DOTFILES_DIR/* # ensure all users can access the dot files

ADD ./dev-images/debian/scripts/entrypoint.sh .

RUN chmod +x entrypoint.sh

SHELL ["/usr/bin/zsh", "-c"]
ENTRYPOINT ["./entrypoint.sh"]
