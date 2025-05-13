#/usr/bin/zsh
DOT_FILES_DIR=${DOT_FILES_DIR:-$HOME/dotfiles}

if [ ! -d "$DOT_FILES_DIR" ]; then
    echo "Cloning dotfiles repository..."
    git clone https://github.com/thomasbellio/mydotfiles.git $DOT_FILES_DIR
else
  echo "Dot files already exist skipping clone."
fi
cd $DOT_FILES_DIR && ./install.sh && cd -
