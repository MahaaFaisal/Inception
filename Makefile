all: build up

up:
	mkdir -p /home/$(USER)/data/mariadb_data
	mkdir -p /home/$(USER)/data/wordpress
	cd srcs && docker-compose up -d

down:
	cd srcs && docker-compose down

build:
	cd srcs && docker-compose build

clean: down
	-sudo docker rmi -f $(shell docker images -q)

re: clean build

fclean:
	@CONTAINERS=$$(docker ps -a -q -f name=nginx -f name=wordpress -f name=mariadb); \
	if [ -n "$$CONTAINERS" ]; then docker rm -f $$CONTAINERS; fi
	- docker volume rm mariadb_data wordpress 2>/dev/null || true
	- sudo rm -rf /home/$(USER)/data
	- yes | sudo docker system prune -a --volumes

.PHONY: all up down build clean fclean re