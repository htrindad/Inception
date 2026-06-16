# Developer documentation

## Architecture
- The browser sends an HTTP request to nginx (with TLS enabled), from which it will request the wordpress page (with FastCGI), and save its contents in MariaDB.
- The containers find each other through a network created on `docker-compose.yml` and called by each container.

## Project layout

- `srcs/docker-compose.yml` contains the instructions for `docker-compose` to create the containers.
- `srcs/.env` environment variables needed for the containers.
- `srcs/requirements/{nginx,wordpress,mariadb}` contains the Dockerfiles and configurations to create the images.
- `secrets/` contains the passwords for the services.

## configurations

The `.env` contains non-secret values, like the database name, the domain name, emails, titles, and URLs.

`secrets/` contains passwords that are read at /run/secrets

## Build and run

To build and run this project. On your `/etc/hosts` add the line `127.0.0.1 htrindad.42.fr`

after that you create a `.env` file on the `srcs` folder, with the following information:

- `DOMAIN_NAME`: the domain you wrote on your `/etc/hosts` file.
- `MYSQL_DATABASE`: the name of your database. This should be left at `wordpress`.
- `MYSQL_USER`: the user for your mysql database.
- `WP_ADMIN_USER`: the admin username for wordpress.
- `WP_ADMIN_EMAIL`: the admin email for wordpress.
- `WP_USER`: the normal username for wordpress.
- `WP_USER_EMAIL`: the normal email for wordpress.
- `WP_URL`: This information should not be different from `DOMAIN_NAME`.
- `WP_TITLE`: Arbitrary name, keep this as `inception` for default.

Then you have to create a secrets directory through:

```sh
$> mkdir -p secrets
```

in which you will create inside the directory the following files like this:

```sh
$> cd secrets/
$> touch db_password.txt db_root_password.txt credentials.txt
```

and write in them accordingly. These files will be transfered to `/run/secrets` inside the container.

**note:** for `credentials.txt` the format is `KEY=value`, and it requires 2 lines. That being `WORDPRESS_ADMIN_PASSWORD`, and `WORDPRESS_USER_PASSWORD`.

**Example:**

```
WORDPRESS_USER_PASSWORD=123
WORDPRESS_ADMIN_PASSWORD=456
```

After that, a simple:

```sh
$> make
```

should work.

## How each service works

- nginx gets their information from port 443 and encrypting it through TLS 1.2/1.3 (It generates a self-signed certificate). And uses `fastcgi_pass` to forward a `.php` request to `wp-php:9000`.
- WordPress is started through `php-fpm` on port `9000`, waits for the database, install WordPress through `wp-cli`, and executes `php-fpm`.
- MariaDB entrypoint inits the database, and the users on the first run, then executes mariadbd.

## Data & persistance

The volumes are backed up in /home/<user>/data. `make fclean` wipes it.

## Troubleshooting

Rebuild after the docker file changes through:

```sh
$> make re
```

check the logs through:

```sh
$> docker logs <name>
```
