run: dockerd build up

dockerd:
	systemctl start docker

# build the docker containers
build:
	docker-compose build

# up the docker containers

up:
	docker-compose up -d

# down the docker containers

down:
	docker-compose down

# stop the docker containers

stop:
	docker-compose stop

# restart the docker containers

restart:
	docker-compose restart

# remove the docker containers

remove:
	docker-compose rm -f

.PHONY: dockerd build up down stop restart remove