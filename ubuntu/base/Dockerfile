# FROM ubuntu
FROM php:8.3.11
# Install necessary packages
RUN apt update -y && \
    apt install -y man-db git ssh openssh-client curl zsh sudo gosu && \
    chsh -s $(which zsh) && \
    mkdir -p /root/.ssh && \
    mkdir -p /root/code/ && \
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
    rm -rf /opt/nvim && \
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz
ENV PATH="$PATH:/opt/nvim-linux-x86_64/bin"
ADD ./entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
