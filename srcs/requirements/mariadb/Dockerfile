FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt install -y mariadb-server

# The package initializes /var/lib/mysql during the build. Wipe it so our
# named volume starts EMPTY and the entrypoint controls first-run setup.
RUN rm -rf /var/lib/mysql/*

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
