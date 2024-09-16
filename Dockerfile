FROM alpine AS builder
RUN mkdir /usr/local/src && apk add binutils --no-cache\
        linux-headers \
	build-base \
        readline-dev \
        openssl-dev \
        ncurses-dev \
        git \
        cmake \
        zlib-dev \
        libsodium-dev \
        gnu-libiconv 

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so
WORKDIR /usr/local/src
RUN git clone https://github.com/SoftEtherVPN/SoftEtherVPN.git
#RUN git clone -b ${GIT_TAG} https://github.com/SoftEtherVPN/SoftEtherVPN.git
ENV USE_MUSL=YES
RUN cd SoftEtherVPN &&\
	git submodule init &&\
	git submodule update &&\
        ./configure $TARGET_CONFIG_FLAGS &&\
	make -j $(getconf _NPROCESSORS_ONLN) -C build

FROM alpine
RUN apk add --no-cache readline \
        openssl \
        libsodium \
        gnu-libiconv \
        iptables
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so
ENV LD_LIBRARY_PATH /root
WORKDIR /usr/local/bin
VOLUME /mnt
RUN ln -s /mnt/vpn_server.config vpn_server.config && \
        mkdir /mnt/backup.vpn_server.config &&\
        ln -s /mnt/backup.vpn_server.config backup.vpn_server.config &&\
        ln -s /mnt/lang.config lang.config
COPY --from=builder /usr/local/src/SoftEtherVPN/build/vpnserver /usr/local/src/SoftEtherVPN/build/vpncmd /usr/local/src/SoftEtherVPN/build/libcedar.so /usr/local/src/SoftEtherVPN/build/libmayaqua.so /usr/local/src/SoftEtherVPN/build/hamcore.se2 ./
COPY --from=builder /usr/local/src/SoftEtherVPN/build/libcedar.so /usr/local/src/SoftEtherVPN/build/libmayaqua.so ../lib/

EXPOSE 443/tcp 992/tcp 1194/tcp 1194/udp 5555/tcp 500/udp 4500/udp
CMD ["/usr/local/bin/vpnserver", "execsvc"]
