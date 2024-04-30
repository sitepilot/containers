#!/usr/bin/env bash

mkdir -p "$OLS_LOGS_DIR" "$OLS_CERTS_DIR"

template ols.conf.tmpl /usr/local/lsws/conf/httpd_config.conf
template ols-app.conf.tmpl /usr/local/lsws/conf/vhosts/app.conf

generate_certs "$OLS_CERTS_DIR"
