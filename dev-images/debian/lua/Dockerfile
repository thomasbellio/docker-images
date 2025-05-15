FROM thomasbell/dev-image:debian-bookworm-cli
RUN curl https://www.lua.org/ftp/lua-5.4.7.tar.gz --output lua-5.4.7.tar.gz && \
        tar -xzf lua-5.4.7.tar.gz
RUN cd  lua-5.4.7 && \
        make all test && \
        mv src/lua /usr/bin/
