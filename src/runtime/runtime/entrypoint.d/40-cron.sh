#!/usr/bin/env bash

set -e
set -u

if ${RUNTIME_CRON_ENABLED:-false} to_bool; then
  info "Cron: Enabled"
  touch  /etc/s6-overlay/s6-rc.d/user/contents.d/cron

  if [[ -f ${RUNTIME_CRONTAB_FILE:-} ]]; then
    info "Crontab: $RUNTIME_CRONTAB_FILE"
    crontab "$RUNTIME_CRONTAB_FILE"
  fi
else
  info "Cron: Disabled"
fi
