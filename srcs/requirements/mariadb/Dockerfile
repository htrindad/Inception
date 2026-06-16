FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.

RUN mkdir /run/mysqld

EXPOSE 3306

CMD [ "mysqld_safe" ]
