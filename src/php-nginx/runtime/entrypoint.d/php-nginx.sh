#!/usr/bin/env bash

mkdir -p "$NGINX_LOGS_DIR" "$NGINX_CERTS_DIR"

template nginx.conf.tmpl /etc/nginx/nginx.conf
template nginx-app.conf.tmpl /etc/nginx/sites-enabled/app.conf

generate_certs "$NGINX_CERTS_DIR"
