#!/usr/bin/env bash

set -e
set -u

template php.ini.tmpl /etc/php/"$PHP_VERSION"/cli/conf.d/50-app.ini
