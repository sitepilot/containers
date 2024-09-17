# Runtime Container Image

All images are based on our [Runtime](./src/runtime) image, which is an optimized and extensible Ubuntu
24.04 LTS container image.

## Filesystem

Application files should be stored in the `/app/files` directory. You may mount the `/app` directory to a volume to
persist application data.

⚠️ The `/runtime` folder should **never** be mounted to a volume.

| Folder                             | Description                                                                                                                                                  |
|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `/app/files`                       | Contains application files                                                                                                                                   |
| `/app/.config/runtime/certs`       | Contains webserver self signed certificates                                                                                                                  |
| `/app/.config/runtime/crontabs`    | Contains user crontab configurations                                                                                                                         |
| `/runtime/bin`                     | Contains executable files used for building and running the container                                                                                        |
| `/runtime/bin/install`             | Installs packages and clean up cache                                                                                                                         |
| `/runtime/bin/rchown`              | Recursively change the owner and group of a folder (this allows services and scripts to access this folder while running the container with a non-root user) |
| `/runtime/entrypoint.d`            | Each file in this folder is executed before the container command is executed                                                                                |
| `/runtime/entrypoint.d/10-logo.sh` | Displays the brand logo                                                                                                                                      |
| `/runtime/entrypoint.d/20-info.sh` | Modifies the user name and password                                                                                                                          |
| `/runtime/entrypoint.d/40-cron.sh` | Enable and configure cron service                                                                                                                            |
| `/runtime/entrypoint.d/40-ssh.sh`  | Enable and configure sshd service                                                                                                                            |
| `/runtime/templates`               | Contains configuration templates                                                                                                                             |

## Environment

| Name                 | Value        | Description                                                                |
|----------------------|--------------|----------------------------------------------------------------------------|
| `RUNTIME_UID`        | `1000`       | The ID of the container user                                               |
| `RUNTIME_GID`        | `1000`       | The ID of the container user group                                         |
| `RUNTIME_USER`       | `app`        | The container user name                                                    |
| `RUNTIME_GROUP`      | `app`        | The container user group                                                   |
| `RUNTIME_VERBOSITY`  | `2`          | The container verbosity (`2` = debug, `1` = info/warning, `0` = error)     |
| `RUNTIME_HOME_DIR`   | `/app`       | Path to the application home directory                                     |
| `RUNTIME_FILES_DIR`  | `/app/files` | Path to the application files directory                                    |
