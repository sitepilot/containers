#!/usr/bin/env bash

set -e
set -u

file_env "RUNTIME_CRONTAB"

if [ -n "$RUNTIME_CRONTAB" ]; then
  info "Cron: Enabled"
  touch  /etc/s6-overlay/s6-rc.d/user/contents.d/cron
  template crontab.tmpl /var/spool/cron/crontabs/"$RUNTIME_USER"
else
  info "Cron: Disabled"
fi
