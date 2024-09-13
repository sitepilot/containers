#!/usr/bin/env bash

set -e
set -u

SSHD_HOME_DIR=$RUNTIME_HOME_DIR/.ssh
SSHD_AUTHORIZED_KEYS_PATH=$SSHD_HOME_DIR/authorized_keys

template sshd_config.tmpl /etc/ssh/sshd_config

mkdir -p /run/sshd

mkdir -p "$SSHD_HOME_DIR" "$SSHD_HOME_DIR"/etc/ssh

info "$(ssh-keygen -A -f /app/.ssh)"

if [[ -n "${SSHD_AUTHORIZED_KEYS:-}" ]]; then
  echo "$SSHD_AUTHORIZED_KEYS" >> "$SSHD_AUTHORIZED_KEYS_PATH"
fi

if [[ -n "${SSHD_AUTHORIZED_KEYS_FILE:-}" ]]; then
  cat "$SSHD_AUTHORIZED_KEYS_FILE" >> "$SSHD_AUTHORIZED_KEYS_PATH"
fi

chown -R "$RUNTIME_UID":"$RUNTIME_GID" "$SSHD_HOME_DIR"
