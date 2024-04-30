#!/usr/bin/env bash

template php.ini.tmpl /etc/php/current/fpm/conf.d/50-app.ini
template pool.conf.tmpl /etc/php/current/fpm/pool.d/app.conf
