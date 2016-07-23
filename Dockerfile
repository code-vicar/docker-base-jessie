FROM buildpack-deps:jessie

MAINTAINER Scott Vickers <scott.w.vickers@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ENV GOSU_DOWNLOAD_SHA256 5ec5d23079e94aea5f7ed92ee8a1a34bbf64c2d4053dadf383992908a2f9dc8a
ENV DUMB_INIT_SHA256 87bdb684cf9ad20dcbdec47ee62389168fb530c024ccd026d95f888f16136e44
ENV GOSU_USER devtools

# Install dumb_init 1.1.1
# Install gosu 1.5
RUN wget -O dumb-init -nv --ca-directory=/etc/ssl/certs "https://github.com/Yelp/dumb-init/releases/download/v1.1.1/dumb-init_1.1.1_amd64" \
&& echo "$DUMB_INIT_SHA256 dumb-init" | sha256sum -c - \
&& wget -O gosu -nv --ca-directory=/etc/ssl/certs "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64" \
&& echo "$GOSU_DOWNLOAD_SHA256 gosu" | sha256sum -c - \
&& chmod +x dumb-init gosu \
&& mv dumb-init gosu /bin

# Add devtools user
RUN mkdir -p /usr/local/devtools \
&& useradd -d /usr/local/devtools devtools \
&& chown -R devtools:devtools /usr/local/devtools

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
