ARG RUNTIME_VERSION=refactor-workflows

FROM ghcr.io/sitepilot/runtime-test:${RUNTIME_VERSION}

USER root

RUN /runtime/bin/install mysql-client ssh-client rsync restic

USER $RUNTIME_UID
