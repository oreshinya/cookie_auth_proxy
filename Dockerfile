FROM buildpack-deps:bookworm

ARG USER=nginx
ARG GROUP=nginx
ARG UID=1000
ARG GID=1000

ARG NGINX_VERSION=1.25.2

RUN groupadd -g $GID $GROUP && \
  useradd -g $GID -u $UID -m -s /bin/bash $USER && \
  apt-get update && apt-get install -y gettext-base

USER $USER

RUN mkdir -p /tmp/build && \
  cd /tmp/build && \
  wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
  tar -zxf nginx-${NGINX_VERSION}.tar.gz && \
  rm nginx-${NGINX_VERSION}.tar.gz && \
  cd /tmp/build/nginx-${NGINX_VERSION} && \
  ./configure \
    --prefix=/home/$USER/nginx \
    --http-log-path=/dev/stdout \
    --error-log-path=/dev/stderr \
    --with-threads && \
  make -j $(getconf _NPROCESSORS_ONLN) && \
  make install && \
  rm -rf /tmp/build

COPY --chown=$USER:$GROUP nginx.conf.template /home/$USER/nginx/conf/nginx.conf.template
COPY --chown=$USER:$GROUP run.sh /home/$USER/run.sh

WORKDIR /home/$USER

CMD ["bash", "run.sh"]
