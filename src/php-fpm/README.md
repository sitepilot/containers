# PHP-FPM Container Image

## TL;DR

```console
docker run --rm ghcr.io/sitepilot/php-fpm:8.3
```

## Base Image

* [PHP](../php)

## Tags

| Name  | Description |
|-------|-------------|
| `8.3` | PHP 8.3     |
| `8.2` | PHP 8.2     |
| `8.1` | PHP 8.1     |
| `8.0` | PHP 8.0     |
| `7.4` | PHP 7.4     |

## Environment

| Name                      | Value   |
|---------------------------|---------|
| `PHP_DATE_TIMEZONE`       | `UTC`   |
| `PHP_MEMORY_LIMIT`        | `256M`  |
| `PHP_MAX_EXECUTION_TIME`  | `300`   |
| `PHP_MAX_INPUT_VARS`      | `10000` |
| `PHP_POST_MAX_SIZE`       | `100M`  |
| `PHP_UPLOAD_MAX_FILESIZE` | `100M`  |

## Logs

| Path                 | Description   |
|----------------------|---------------|
| `/app/logs/php.log`  | PHP error log |
| `/app/logs/mail.log` | PHP mail log  |

## Packages

* [php-fpm](https://www.php.net/manual/en/install.fpm.php)
