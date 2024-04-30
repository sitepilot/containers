# --------------- [RUNTIME] --------------- #

FROM ubuntu:22.04 as runtime

ARG TARGETARCH
ARG S6_VERSION=v3.1.6.2
ARG DOCKERIZE_VERSION=v0.7.0

ENV RUNTIME_UID=1000 \
    RUNTIME_GID=1000 \
    RUNTIME_USER=app \
    RUNTIME_GROUP=app \
    RUNTIME_HOME_DIR=/app \
    RUNTIME_FILES_DIR=/app/files \
    RUNTIME_VERBOSITY=1 \
    RUNTIME_S6_ENABLED=false

COPY --chmod=755 ./runtime /runtime

RUN /runtime/bin/install curl xz-utils ca-certificates \
    && groupadd -r -g ${RUNTIME_GID} ${RUNTIME_GROUP} \
    && useradd --no-log-init -r -s /usr/bin/bash -m -d ${RUNTIME_HOME_DIR} -u ${RUNTIME_UID} -g ${RUNTIME_GID} ${RUNTIME_USER} \
    && chown $RUNTIME_UID:$RUNTIME_GID /run \
    && curl -L https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-noarch.tar.xz -o - | tar Jxp -C / \
    && curl -L https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-$(uname -m).tar.xz -o - | tar Jxp -C / \
    && curl -L https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-${TARGETARCH}-${DOCKERIZE_VERSION}.tar.gz -o - | tar xzf - -C /runtime/bin

USER ${RUNTIME_UID}

RUN mkdir -p $RUNTIME_FILES_DIR

WORKDIR $RUNTIME_FILES_DIR

ENTRYPOINT ["/runtime/entrypoint"]

# --------------- [php] --------------- #

FROM runtime as php

USER root

ARG BUILD_VERSION=8.3

ENV RUNTIME_VERBOSITY=0

COPY --chmod=755 ./php /

RUN /runtime/bin/install gnupg2 software-properties-common less msmtp unzip \
    && add-apt-repository ppa:ondrej/php \
    && mkdir -p /etc/php/current \
    && ln -sf /etc/php/current /etc/php/${BUILD_VERSION} \
    && /runtime/bin/install $(cat /packages/php-${BUILD_VERSION}.txt) \
    && /runtime/bin/rchown /etc/php/current \
    && rm -rf /packages

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY --from=wordpress:cli-2 /usr/local/bin/wp /usr/local/bin/wp

USER ${RUNTIME_UID}

# --------------- [php-fpm] --------------- #

FROM php AS php-fpm

USER root

ENV RUNTIME_VERBOSITY=1

RUN /runtime/bin/install php${BUILD_VERSION}-fpm libfcgi-bin \
    && ln -sf /usr/sbin/php-fpm${BUILD_VERSION} /usr/sbin/php-fpm \
    && rm /etc/php/current/fpm/pool.d/www.conf \
    && /runtime/bin/rchown /etc/php/current

COPY --chmod=755 ./php-fpm /

USER $RUNTIME_UID

EXPOSE 9000

CMD ["php-fpm", "-F"]

# --------------- [PHP-NGINX] --------------- #

FROM php-fpm AS php-nginx

USER root

ENV NGINX_LOGS_DIR="$RUNTIME_HOME_DIR/logs" \
    NGINX_CERTS_DIR="$RUNTIME_HOME_DIR/certs" \
    NGINX_PUBLIC_DIR="/" \
    RUNTIME_S6_ENABLED=true

RUN /runtime/bin/install nginx \
    && rm /etc/nginx/sites-enabled/default \
    && /runtime/bin/rchown /etc/nginx /var/log/nginx /var/lib/nginx \
    && setcap "cap_net_bind_service=+ep" /usr/sbin/nginx

COPY --chmod=755 ./php-nginx /

USER $RUNTIME_UID

EXPOSE 80

EXPOSE 443

# --------------- [PHP-OLS] --------------- #

FROM php-fpm AS php-ols

USER root

ENV OLS_LOGS_DIR="$RUNTIME_HOME_DIR/logs" \
    OLS_CERTS_DIR="$RUNTIME_HOME_DIR/certs" \
    OLS_PUBLIC_DIR="/" \
    RUNTIME_S6_ENABLED=true

RUN curl http://rpms.litespeedtech.com/debian/lst_debian_repo.gpg -o /etc/apt/trusted.gpg.d/lst_debian_repo.gpg  \
    && curl http://rpms.litespeedtech.com/debian/lst_repo.gpg -o /etc/apt/trusted.gpg.d/lst_repo.gpg \
    && echo "deb http://rpms.litespeedtech.com/debian/ jammy main" > /etc/apt/sources.list.d/lst_debian_repo.list \
    && /runtime/bin/install openlitespeed \
    && /runtime/bin/rchown /usr/local/lsws \
    && setcap "cap_net_bind_service=+ep" /usr/local/lsws/bin/openlitespeed

COPY --chmod=755 ./php-ols /

USER $RUNTIME_UID

EXPOSE 80

EXPOSE 443
