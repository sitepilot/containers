#!/usr/bin/env bash

set -e
set -u

if ${RUNTIME_CRON_ENABLED:-false} to_bool; then
  info "Cron: Enabled"
  touch  /etc/s6-overlay/s6-rc.d/user/contents.d/cron

  if [[ -n ${RUNTIME_CRONTAB_FILE:-} ]]; then
    RUNTIME_CRONTAB="$(cat "$RUNTIME_CRONTAB_FILE")"
    export RUNTIME_CRONTAB
  fi

  template crontab.tmpl /var/spool/cron/crontabs/"$RUNTIME_USER"
else
  info "Cron: Disabled"
fi
