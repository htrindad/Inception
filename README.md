# Inception

*This project has been created as part of the 42 curriculum by htrindad*

## Description

Inception is a 42 project, where our objective is through `docker compose`, create 3 services (that being the nginx server, a wordpress website, and a mariadb mysql database), through by creating each own docker file.

The server starts with NGINX with TLS on port 443 (All traffic only happens here. Nothing can access the other services). WordPress in conjunction with php-fpm (under port 9000). Sending it's info to mariadb (port 3306).

The project contains 2 named volumes for database and wordpress data.

It creates a self-signed certificate, uses secrets for passwords (db_password.txt, db_root_password.txt, credentials.txt)

## Instructions

For this project to work we need:
- `docker` as well as `docker-compose`
- add `htrindad.42.fr` to `/etc/host`
- create secrets, with the `db_password.txt`, `db_root_password.txt`, and `credentials.txt`
- Link to https://htrindad.42.fr and accept the self-signed certificate warning.

The project has a make file, with the targets: `up`, `down` `stop`, `start`, `status`, `clean`, `fclean`, `restart`, and `re`

### up

starts the docker containers through `docker compose`.

### down

shutdowns the docker containers through `docker compose`.

### stop

shutdowns the docker containers as well as it's resources.

### start

similar to `up`, but only restarts existing stopped containers.

### status

Prints out the current information on existing docker containers.

### clean

downs all the containers, and frees up the space said containers occupy

### fclean

calls `clean`, and removes the data.

### restart

calls `stop`, then `up`

### re

calls `clean`, then `up`

---

to run each one of them. Run:

```sh 
$> make <target>
```

## resources

### How AI was used

I'm not used with Docker and container orchestration (docker compose and YAML), so I used Claude Code as a tutor to learn those and to debug. It helped me understand concepts such as PID 1, named volumes, and FastCGI.

### Conecpt comparisons

#### VMs vs. Docker

A VM tries to replicate the host hardware with the operator's OS. This is slow and heavy, not to mention it's environment is very isolated.

When using containers, all of them share the host's kernel, and each one of them work in their own process level.

#### Secrets vs. Environment variables

Env vars, are exposed, and you can easily access them through `docker inspect` or `proc`. They easily leak into git. Secrets are mounted files at runtime.

#### Docker network vs. Host network

Docker networks bridge the containers, isolates the container's ips, and gives them a name based DNS so they can communicate with each-other by name. Host networking removes the isolation, and have to call the port directly from ip.

#### Docker volumes vs. Bind mounts

Docker volumes are completely managed by docker. Bind mounts are depended by the OS.

### References

I mainly used these 5 articles:

- [Inception guide, by. @ssterdev](https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671)
- [Forstman1's guide](https://github.com/Forstman1/inception-42)
- [Vbachele's guide](https://github.com/vbachele/Inception)
- [llescure's guide](https://github.com/llescure/42_Inception)
- [malatini's guide](https://github.com/malatini42/inception)
