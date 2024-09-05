FROM ubuntu:22.04

ARG TARGETARCH
ARG S6_VERSION=v3.1.6.2
ARG DOCKERIZE_VERSION=v0.7.0

ENV RUNTIME_UID=1000 \
    RUNTIME_GID=1000 \
    RUNTIME_USER=app \
    RUNTIME_GROUP=app \
    RUNTIME_HOME_DIR=/app \
    RUNTIME_FILES_DIR=/app/files \
    RUNTIME_LOGS_DIR=/app/logs \
    RUNTIME_VERBOSITY=1 \
    RUNTIME_S6_ENABLED=false

COPY --chmod=755 ./rootfs/runtime/bin /runtime/bin

RUN /runtime/bin/install curl xz-utils ca-certificates nano \
    && groupadd -r -g ${RUNTIME_GID} ${RUNTIME_GROUP} \
    && useradd --no-log-init -r -s /usr/bin/bash -m -d ${RUNTIME_HOME_DIR} -u ${RUNTIME_UID} -g ${RUNTIME_GID} ${RUNTIME_USER} \
    && chown $RUNTIME_UID:$RUNTIME_GID /run \
    && curl -L https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-noarch.tar.xz -o - | tar Jxp -C / \
    && curl -L https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-$(uname -m).tar.xz -o - | tar Jxp -C / \
    && curl -L https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-${TARGETARCH}-${DOCKERIZE_VERSION}.tar.gz -o - | tar xzf - -C /runtime/bin \
    && chown -R $RUNTIME_UID:$RUNTIME_GID /etc/s6-overlay/s6-rc.d/user

COPY --chown=$RUNTIME_UID:$RUNTIME_GID ./rootfs /

USER ${RUNTIME_UID}

RUN mkdir -p $RUNTIME_FILES_DIR

WORKDIR $RUNTIME_FILES_DIR

ENTRYPOINT ["/runtime/entrypoint"]
