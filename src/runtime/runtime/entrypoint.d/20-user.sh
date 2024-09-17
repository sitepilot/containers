#!/usr/bin/env bash

set -e
set -u

file_env "RUNTIME_USER"
file_env "RUNTIME_PASSWORD"

info "User: $RUNTIME_USER"
sed -i -e "s,^app:,$RUNTIME_USER:,g" /etc/passwd
sed -i -e "s,^app:!:,$RUNTIME_USER:${RUNTIME_PASSWORD:-!}:,g" /etc/shadow
