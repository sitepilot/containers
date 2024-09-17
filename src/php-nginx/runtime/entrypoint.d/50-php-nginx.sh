#!/usr/bin/env bash

generate_certs

template nginx.conf.tmpl /etc/nginx/nginx.conf
template nginx-app.conf.tmpl /etc/nginx/sites-enabled/app.conf
