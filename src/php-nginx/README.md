# PHP-FPM & Nginx Container Image

## TL;DR

```console
docker run --rm ghcr.io/sitepilot/php-nginx:8.3
```

## Base Image

* [PHP-FPM](../php-fpm)

## Tags

| Name  | Description |
|-------|-------------|
| `8.3` | PHP 8.3     |
| `8.2` | PHP 8.2     |
| `8.1` | PHP 8.1     |
| `8.0` | PHP 8.0     |
| `7.4` | PHP 7.4     |

## Environment

| Name                      | Value             |
|---------------------------|-------------------|
| `NGINX_PUBLIC_DIR`        | -                 |
| `NGINX_GZIP_ENABLED`      | `true`            |
| `NGINX_GZIP_COMP_LEVEL`   | `5`               |
| `NGINX_GZIP_VARY`         | `on`              |
| `NGINX_GZIP_STATIC`       | `off`             |
| `NGINX_SET_REAL_IP_FROM`  | `0.0.0.0/0`       |
| `NGINX_REAL_IP_HEADER`    | `X-Forwarded-For` |
| `NGINX_REAL_IP_RECURSIVE` | `on`              |
 
## Logs

| Path                      | Description     |
|---------------------------|-----------------|
| `/app/logs/nginx.log`     | Nginx error log |

## Packages

* [nginx](https://www.nginx.com/)
