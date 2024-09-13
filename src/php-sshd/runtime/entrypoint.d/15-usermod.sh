#!/usr/bin/env bash

set -e
set -u

if [[ ! -f $RUNTIME_BOOTED_FILE ]]; then
  if [[ $RUNTIME_USER != "app" ]]; then
    info "Updating user to $RUNTIME_USER"
    usermod -l "$RUNTIME_USER" app
  fi

  if [[ $RUNTIME_GROUP != "app" ]]; then
    info "Updating group to $RUNTIME_GROUP"
    groupmod -n "$RUNTIME_GROUP" app
  fi

  if [[ $RUNTIME_UID != 1000 ]]; then
    info "Updating UID to $RUNTIME_UID"
    usermod -o -u "$RUNTIME_UID" "$RUNTIME_USER"
  fi

  if [[ $RUNTIME_GID != 1000 ]]; then
    info "Updating GID to $RUNTIME_UID"
    groupmod -o -g "$RUNTIME_GID" "$RUNTIME_GROUP"
  fi

  if [[ -n ${RUNTIME_PASSWORD_FILE:-} ]]; then
    RUNTIME_PASSWORD="$(cat "$RUNTIME_PASSWORD_FILE")"
  fi

  if [[ -n "${RUNTIME_PASSWORD:-}" ]]; then
    info "Updating user password"
    echo "$RUNTIME_USER:$RUNTIME_PASSWORD" | chpasswd
  fi
fi
