all:
	mkdir -p /home/nmikuka/data/mariadb /home/nmikuka/data/wordpress
	docker compose -f srcs/docker-compose.yml up --build

down:
	docker compose -f srcs/docker-compose.yml down

re:
	docker compose -f srcs/docker-compose.yml down -v
	docker compose -f srcs/docker-compose.yml up --build

clean:
	docker compose -f srcs/docker-compose.yml down -v
	docker system prune -af

fclean: clean
	docker volume prune -f

.PHONY: all down re clean fclean
