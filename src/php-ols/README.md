# PHP-FPM & OpenLiteSpeed Container Image

## TL;DR

```console
docker run --rm ghcr.io/sitepilot/php-ols:8.3
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

| Name             | Value |
|------------------|-------|
| `OLS_PUBLIC_DIR` | -     |

## Logs

| Path                          | Description             |
|-------------------------------|-------------------------|
| `/app/logs/openlitespeed.log` | OpenLiteSpeed error log |

## Packages

* [openlitespeed](https://openlitespeed.org/)
