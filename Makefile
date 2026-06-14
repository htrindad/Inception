up:
	@docker compose -f ./srcs/docker-compose.yml up -d

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

restart: stop up

re: clean up
