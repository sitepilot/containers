# Container Image Library

This repository contains a collection of optimized and extensible container images for running web applications in
production.

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

## Runtime

All images are based on our [runtime](./src/runtime) image, an optimized and extensible Ubuntu 22.04 LTS
container image.

### Filesystem

⚠️ The `/runtime` folder should **never** be mounted to a volume.

| Folder                             | Description                                                                                                                                                  |
|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `/runtime/bin`                     | Contains executable files used for building and running the container                                                                                        |
| `/runtime/bin/install`             | Installs packages and clean up cache                                                                                                                         |
| `/runtime/bin/rchown`              | Recursively change the owner and group of a folder (this allows services and scripts to access this folder while running the container with a non-root user) |
| `/runtime/entrypoint.d`            | Each file in this folder is executed before the container command is executed                                                                                |
| `/runtime/entrypoint.d/10-logo.sh` | Displays the brand logo                                                                                                                                      |
| `/runtime/entrypoint.d/20-info.sh` | Displays container info                                                                                                                                      |
| `/runtime/templates`               | Contains configuration templates                                                                                                                             |

### Environment

| Name                 | Value        | Description                                                                |
|----------------------|--------------|----------------------------------------------------------------------------|
| `RUNTIME_UID`        | `1000`       | The ID of the container user                                               |
| `RUNTIME_GID`        | `1000`       | The ID of the container user group                                         |
| `RUNTIME_USER`       | `app`        | The container user name                                                    |
| `RUNTIME_GROUP`      | `app`        | The container user group                                                   |
| `RUNTIME_VERBOSITY`  | `2`          | The container verbosity (`2` = debug, `1` = info/warning, `0` = error)     |
| `RUNTIME_WORKDIR`    | `/app`       | Path to the application home directory                                     |
| `RUNTIME_FILES_DIR`  | `/app/files` | Path to the application files directory                                    |
| `RUNTIME_S6_ENABLED` | `false`      | Enable/disable [s6-overlay](https://github.com/just-containers/s6-overlay) |
