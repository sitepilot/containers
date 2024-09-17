# --------------- [runtime] --------------- #

FROM ubuntu:24.04 AS runtime

ARG TARGETARCH
ARG S6_VERSION=v3.2.0.0
ARG DOCKERIZE_VERSION=v0.8.0

ENV RUNTIME_UID=1000 \
    RUNTIME_GID=1000 \
    RUNTIME_USER=app \
    RUNTIME_GROUP=app \
    RUNTIME_HOME_DIR=/app \
    RUNTIME_FILES_DIR=/app/files \
    RUNTIME_LOGS_DIR=/app/logs \
    RUNTIME_VERBOSITY=1 \
    RUNTIME_BOOTED_FILE=/runtime/booted \
    RUNTIME_CRONTABS_DIR=/app/.config/crontabs

COPY --chmod=755 ./runtime/runtime/bin /runtime/bin

RUN /runtime/bin/install  \
      curl  \
      nano \
      ca-certificates  \
      xz-utils  \
      openssh-server  \
      cron \
      restic \
    && userdel ubuntu \
    && groupadd -r -g $RUNTIME_GID $RUNTIME_GROUP \
    && useradd --no-log-init -r -s /usr/bin/bash -m -d $RUNTIME_HOME_DIR -u $RUNTIME_UID -g $RUNTIME_GID $RUNTIME_USER \
    && curl -L https://github.com/just-containers/s6-overlay/releases/download/$S6_VERSION/s6-overlay-noarch.tar.xz -o - | tar Jxp -C / \
    && curl -L https://github.com/just-containers/s6-overlay/releases/download/$S6_VERSION/s6-overlay-$(uname -m).tar.xz -o - | tar Jxp -C / \
    && curl -L https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-${TARGETARCH}-$DOCKERIZE_VERSION.tar.gz -o - | tar xzf - -C /runtime/bin \
    && /runtime/bin/rchown /run /etc/ssh /etc/s6-overlay/s6-rc.d/user /var/spool/cron/crontabs \
    && rm /etc/update-motd.d/* \
    && chmod u+s /usr/sbin/cron

RUN chown $RUNTIME_UID:$RUNTIME_GID /etc/passwd /etc/shadow

COPY --chown=$RUNTIME_UID:$RUNTIME_GID runtime /

USER $RUNTIME_UID

RUN mkdir $RUNTIME_FILES_DIR

WORKDIR $RUNTIME_FILES_DIR

ENTRYPOINT ["/runtime/entrypoint"]

# --------------- [php-fpm] --------------- #

FROM runtime as php-cli

ARG BUILD_VERSION=8.3

ENV RUNTIME_VERBOSITY=0 \
    PHP_VERSION=${BUILD_VERSION}

USER root

COPY php-cli/runtime/packages /runtime/packages

RUN /runtime/bin/install \
      gnupg2  \
      software-properties-common \
      less \
      unzip \
      mysql-client \
    && add-apt-repository ppa:ondrej/php \
    && /runtime/bin/install $(cat /runtime/packages/php-${PHP_VERSION}.txt) \
    && /runtime/bin/rchown /etc/php

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY --from=wordpress:cli-2 /usr/local/bin/wp /usr/local/bin/wp
COPY --from=node:20-slim /usr/local/bin /usr/local/bin
COPY --from=node:20-slim /usr/local/lib/node_modules /usr/local/lib/node_modules

COPY --chown=$RUNTIME_UID:$RUNTIME_GID php-cli /

USER $RUNTIME_UID

# --------------- [php-fpm] --------------- #

FROM php-cli as php-fpm

ENV RUNTIME_VERBOSITY=1

USER root

RUN /runtime/bin/install php${PHP_VERSION}-fpm \
    && ln -sf /usr/sbin/php-fpm$PHP_VERSION /usr/sbin/php-fpm \
    && rm /etc/php/$PHP_VERSION/fpm/pool.d/www.conf \
    && /runtime/bin/rchown /etc/php

COPY --chown=$RUNTIME_UID:$RUNTIME_GID php-fpm /

USER $RUNTIME_UID

CMD ["php-fpm", "-F"]

# --------------- [php-nginx] --------------- #

FROM php-fpm AS php-nginx

ENV NGINX_CERTS_DIR="$RUNTIME_HOME_DIR/certs"

USER root

RUN /runtime/bin/install nginx \
    && rm /etc/nginx/sites-enabled/default \
    && /runtime/bin/rchown /etc/nginx /var/log/nginx /var/lib/nginx \
    && setcap "cap_net_bind_service=+ep" /usr/sbin/nginx

COPY --chown=$RUNTIME_UID:$RUNTIME_GID ./php-nginx /

USER $RUNTIME_UID

EXPOSE 80

EXPOSE 443

HEALTHCHECK --interval=2s --timeout=1s --retries=5 \
  CMD curl -f http://localhost/-/ping/ || exit 1

# --------------- [php-ols] --------------- #

FROM php-fpm AS php-ols

ENV OLS_CERTS_DIR="$RUNTIME_HOME_DIR/certs"

USER root

RUN curl -s https://repo.litespeed.sh | bash \
    && /runtime/bin/install openlitespeed \
    && /runtime/bin/rchown /usr/local/lsws \
    && setcap "cap_net_bind_service=+ep" /usr/local/lsws/bin/openlitespeed

COPY --chown=$RUNTIME_UID:$RUNTIME_GID ./php-ols /

USER $RUNTIME_UID

EXPOSE 80

EXPOSE 443

HEALTHCHECK --interval=2s --timeout=1s --retries=5 \
  CMD curl -f http://localhost/-/ping/ || exit 1
