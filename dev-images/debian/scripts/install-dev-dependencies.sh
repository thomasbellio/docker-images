#!/bin/bash
apt update -y && \
apt install -y dnsutils && \
apt install -y pass && \
apt install -y ack gcc make man-db git ssh openssh-client curl zsh sudo gosu tmux && \
apt install -y xauth x11-apps xclip && \
chsh -s $(which zsh) && \
mkdir -p /root/.ssh && \
mkdir -p /root/code/ && \
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
rm -rf /opt/nvim && \
tar -C /opt -xzf nvim-linux-x86_64.tar.gz
