# Container Image Library

This repository contains a collection of optimized and extensible container images for running web applications in
production. All images are based on our [Runtime](./src/runtime) image, which is an optimized and extensible Ubuntu
24.04 LTS container image.

## Usage

The recommended way to get any of our images is to pull the prebuilt image from the GitHub Registry:

```bash
docker run ghcr.io/sitepilot/image:tag
```

For example, if you wish to run **PHP 8.3** with **PHP-FPM** & **NGINX**, use the following image:

```bash
docker run --rm ghcr.io/sitepilot/php:8.3-fpm-nginx
```

## Customization

To use an image as a base image and avoid potential breaking changes in your container builds, use the following
image naming pattern in your `Dockerfile`:

```Dockerfile
FROM ghcr.io/sitepilot/image:tag-branch
```

For example, if you wish to customize the **PHP 8.3** with **FPM** & **NGINX** image:

```Dockerfile
FROM ghcr.io/sitepilot/php:8.3-fpm-nginx-2.x
```

## Images

The following container images are available:

| Image                                    | Variation | Tags                                                                      | Description                                                                                                                                                            |
|------------------------------------------|-----------|---------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [ghcr.io/sitepilot/php](./src/php-cli)   | cli       | 7.4, 8.0, 8.1, 8.2, 8.3                                                   | If you need to execute a quick command with tools like Composer, WPCLI or run a PHP script exclusively in the command line, this could be an excellent option for you. |
| [ghcr.io/sitepilot/php](./src/php-nginx) | fpm-nginx | 7.4-fpm-nginx, 8.0-fpm-nginx, 8.1-fpm-nginx, 8.2-fpm-nginx, 8.3-fpm-nginx | Ideal for running Laravel or similar applications. It allows NGINX to serve static content efficiently while routing PHP requests to PHP-FPM.                          |
| [ghcr.io/sitepilot/php](./src/php-ols)   | fpm-ols   | 7.4-fpm-ols, 8.0-fpm-ols, 8.1-fpm-ols, 8.2-fpm-ols, 8.3-fpm-ols           | Ideal for running WordPress or similar applications. It allows OpenLiteSpeed to serve static (and cached) content efficiently while routing PHP requests to PHP-FPM.   |
