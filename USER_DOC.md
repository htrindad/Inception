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
