# Container Image Library

This repository contains a collection of optimized and extensible container images for running web applications in
production. All images are based on our [Runtime](./src/runtime) image, which is an optimized and extensible Ubuntu
22.04 LTS container image.

## Usage

The recommended way to get any of our images is to pull the prebuilt image from the GitHub Registry:

```bash
docker run ghcr.io/sitepilot/image:tag
```

For example, if you wish to run **PHP 8.3** with **PHP-FPM** & **NGINX**, use the following image:

```bash
docker run --rm ghcr.io/sitepilot/php-nginx:8.3
```

## Customization

To use an image as a base image and avoid potential breaking changes in your container builds, use the following
image naming pattern in your `Dockerfile`:

```Dockerfile
FROM ghcr.io/sitepilot/image:tag-branch
```

For example, if you wish to customize the **PHP 8.3** with **FPM** & **NGINX** image:

```Dockerfile
FROM ghcr.io/sitepilot/php-nginx:8.3-1.x
```

## Images

The following container images are available:

| Image                                          | Tags                    | Description             |
|------------------------------------------------|-------------------------|-------------------------|
| [ghcr.io/sitepilot/php](./src/php)             | 7.4, 8.0, 8.1, 8.2, 8.3 | PHP                     |
| [ghcr.io/sitepilot/php-fpm](./src/php-fpm)     | 7.4, 8.0, 8.1, 8.2, 8.3 | PHP-FPM                 |
| [ghcr.io/sitepilot/php-nginx](./src/php-nginx) | 7.4, 8.0, 8.1, 8.2, 8.3 | PHP-FPM & Nginx         |
| [ghcr.io/sitepilot/php-ols](./src/php-ols)     | 7.4, 8.0, 8.1, 8.2, 8.3 | PHP-FPM & OpenLiteSpeed |
