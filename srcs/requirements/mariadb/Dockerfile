FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt install -y mariadb-server

EXPOSE 3306

CMD [ "mysqld_safe" ]
