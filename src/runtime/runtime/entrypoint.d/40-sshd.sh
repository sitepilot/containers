#!/usr/bin/env bash

set -e
set -u

file_env "RUNTIME_SSHD_AUTH_KEYS"

if ${RUNTIME_SSHD_ENABLED:-false} to_bool; then
  info "SSHD: Enabled"

  touch  /etc/s6-overlay/s6-rc.d/user/contents.d/sshd

  mkdir -p /run/sshd ~/.ssh/etc/ssh

  ssh-keygen -A -f ~/.ssh > /dev/null

  template sshd_config.tmpl /etc/ssh/sshd_config

  template authorized_keys.tmpl ~/.ssh/authorized_keys
else
  info "SSHD: Disabled"
fi
