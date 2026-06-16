FROM debian:bookworm

# php8.2-fpm for FastCGI
# php8.2-mysql for communication between wordpress and mysql

RUN apt update -y && apt upgrade -y && apt install -y php8.2-fpm php8.2-mysql wget mariadb-client
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
	&& chmod +x /usr/local/bin/wp

COPY www.conf /etc/php/8.2/fpm/pool.d/.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
