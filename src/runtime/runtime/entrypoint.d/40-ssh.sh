#!/usr/bin/env bash

set -e
set -u

if ${RUNTIME_SSH_ENABLED:-false} to_bool; then
  info "SSH Server: Enabled"

  if [[ -f ${RUNTIME_SSH_KEYS_FILE:-} ]]; then
    info "Auth Keys: $RUNTIME_SSH_KEYS_FILE"
  fi

  touch  /etc/s6-overlay/s6-rc.d/user/contents.d/sshd

  template sshd_config.tmpl /etc/ssh/sshd_config

  mkdir -p /run/sshd ~/.ssh/etc/ssh

  debug "$(ssh-keygen -A -f ~/.ssh)"
else
  info "SSH Server: Disabled"
fi
