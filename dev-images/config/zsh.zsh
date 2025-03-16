#/usr/bin/zsh
git config --global --add safe.directory '*' && \
if [ ! -d "$HOME/dotfiles" ]; then
    echo "Cloning dotfiles repository..."
    git clone https://github.com/thomasbellio/mydotfiles.git $HOME/dotfiles && \
else
  echo "Dot files already exist skipping clone."
fi
ln -s $HOME/dotfiles/zsh/zshconfig-v2 $HOME/.zshrc && \

