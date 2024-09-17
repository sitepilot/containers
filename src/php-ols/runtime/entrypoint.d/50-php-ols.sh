#!/usr/bin/env bash

generate_certs

template ols.conf.tmpl /usr/local/lsws/conf/httpd_config.conf
template ols-app.conf.tmpl /usr/local/lsws/conf/vhosts/app.conf
