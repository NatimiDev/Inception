all:
	mkdir -p /home/nmikuka/data/mariadb /home/nmikuka/data/wordpress
	docker compose -f srcs/docker-compose.yml up --build -d

dev:
	mkdir -p /home/nmikuka/data/mariadb /home/nmikuka/data/wordpress
	docker compose -f srcs/docker-compose.yml up --build

down:
	docker compose -f srcs/docker-compose.yml down

re: fclean all

clean:
	docker compose -f srcs/docker-compose.yml down -v
	docker system prune -af

fclean: clean
	sudo rm -rf /home/nmikuka/data/mariadb/*
	sudo rm -rf /home/nmikuka/data/wordpress/*
	
.PHONY: all down re clean fclean
