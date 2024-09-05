ARG RUNTIME_VERSION=1.x

FROM ghcr.io/sitepilot/runtime:${RUNTIME_VERSION}

USER root

RUN /runtime/bin/install mysql-client ssh-client rsync restic

USER $RUNTIME_UID
