#!/usr/bin/env bash

set -e
set -u

if [[ ! -f $RUNTIME_BOOTED_FILE ]]; then
  if [[ -n ${RUNTIME_PASSWORD_FILE:-} ]]; then
    RUNTIME_PASSWORD="$(cat "$RUNTIME_PASSWORD_FILE")"
  fi

  if [[ $RUNTIME_USER != "app" ]]; then
    info "User: $RUNTIME_USER"
    sed -i -e "s,^app:,$RUNTIME_USER:,g" /etc/passwd
    sed -i -e "s,^app:!:,$RUNTIME_USER:${RUNTIME_PASSWORD:-'!'}:,g" /etc/shadow
  fi
fi
