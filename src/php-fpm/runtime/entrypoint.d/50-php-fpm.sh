#!/usr/bin/env bash

set -e
set -u

template php.ini.tmpl /etc/php/"$PHP_VERSION"/fpm/conf.d/50-app.ini
template pool.conf.tmpl /etc/php/"$PHP_VERSION"/fpm/pool.d/app.conf
