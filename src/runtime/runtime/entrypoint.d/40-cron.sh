#!/usr/bin/env bash

set -e
set -u

if ${RUNTIME_CRON_ENABLED:-false} to_bool; then
  info "Cron: Enabled"
  touch  /etc/s6-overlay/s6-rc.d/user/contents.d/cron
  mkdir -p "$RUNTIME_CRONTABS_DIR"
else
  info "Cron: Disabled"
fi
