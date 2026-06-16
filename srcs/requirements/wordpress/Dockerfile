FROM debian:bookworm

# php8.2-fpm for FastCGI
# php8.2-mysql for communication between wordpress and mysql

RUN apt update -y && apt upgrade -y && apt install -y php8.2-fpm php8.2-mysql wget

COPY www.conf /etc/php/8.2/fpm/pool.d/.

EXPOSE 9000

CMD [ "php-fpm8.2", "-F" ]
