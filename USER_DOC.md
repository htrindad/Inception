# User documentation

- This is a wordpress website that can be reached through the link `https://htrindad.42.fr`
- For log-in, go to `/wp-admin`, use the admin account (username: `staff`).
- For each account:
    - `staff` has full control of the pages, posts, settings, and users.
    - `htrindad` can write and edit their own posts, but not the pages or settings.
- To create a post, go to posts -> add post -> publish

# Start and stop the stack

To start the stack:

```sh
$> make up
```

To stop the stack

```sh
$> make down
```

# Access the website

You can access it through the link `https://htrindad.42.fr`

## Access the admin panel

You can access it through `https://htrindad.42.fr/wp-admin`

# Manage credentials

- WordPress account passwords: login as `staff` -> Users -> edit the user -> Set a new password.
- Infrastructure passwords live in the `secrets/` files  (`db_password.txt`, `db_root_password.txt`, `credentials.txt`). To change them, edit the file and rebuild from scratch: `make fclean` then `make up`.

# Basic checks

- To confirm the 3 containers are running, run: `make status` -- You should see `nginx`, `wp-php`, and `mariadb` up.
- To confirm the site responds: link to `https://htrindad.42.fr` (accept the self-signed certificate warning).
- Inspect a service as if something looks off: `docker logs <container>` (e.g. `docker logs wp-php`)
