#!/usr/bin/env bash

set -e
set -u

if ${RUNTIME_SSH_ENABLED:-false} to_bool; then
  info "SSH Server: Enabled"

  touch  /etc/s6-overlay/s6-rc.d/user/contents.d/sshd

  mkdir -p /run/sshd ~/.ssh/etc/ssh

  ssh-keygen -A -f ~/.ssh > /dev/null

  if [[ -n ${RUNTIME_SSH_AUTH_KEYS_FILE:-} ]]; then
    RUNTIME_SSH_AUTH_KEYS="$(cat "$RUNTIME_SSH_AUTH_KEYS_FILE")"
    export RUNTIME_SSH_AUTH_KEYS
  fi

  template sshd_config.tmpl /etc/ssh/sshd_config

  template authorized_keys.tmpl ~/.ssh/authorized_keys
else
  info "SSH Server: Disabled"
fi
