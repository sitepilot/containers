#!/usr/bin/env bash

info "User: ${RUNTIME_USER} (uid: $(id -u "$RUNTIME_USER"))"
info "Group: ${RUNTIME_GROUP} (gid: $(id -g "$RUNTIME_USER"))"
info "Workdir: $PWD"
