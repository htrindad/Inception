FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout	/etc/nginx/ssl/inception.key \
		-out	/etc/nginx/ssl/inception.crt \
		-subj	"/C=PT/ST=Lisbon/O=42/CN=htrindad.42.fr"

COPY default /etc/nginx/sites-available/default

CMD [ "nginx", "-g", "daemon off;" ]
