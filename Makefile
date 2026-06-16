up:
	@mkdir -p /home/htrindad/data/wordpress /home/htrindad/data/mariadb
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

start:
	@docker compose -f ./srcs/docker-compose.yml start

status:
	@docker ps

clean:
	docker compose -f ./srcs/docker-compose.yml down --rmi all -v
	docker container prune -f

restart: stop up

re: clean up
