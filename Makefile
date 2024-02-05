#!/usr/bin/make

$(shell touch ${CURDIR}/password.env)
include password.env
export

# run services
.PHONY: deploy
deploy: build-wordpress
	docker compose up -d

# stop all services
.PHONY: stop
stop:
	docker compose down

# build custom wordpress image
.PHONY: build-wordpress
build-wordpress:
	docker compose build wordpress

# build custom alpine image
.PHONY: build-alpine
build-alpine:
	docker compose build alpine

# build all custom images
.PHONY: build
build:
	docker compose build

# backup content of all docker volumes locally
.PHONY: backup
backup:
	docker compose run alpine bash -c "./bin/backup-volumes"

# synchonize backups to server
PHONY: backup-and-rsync
backup-and-rsync: backup
	./bin/rsync-to-server

# restore data from backup
.PHONY: restore-from-backup
restore-from-backup: stop
	docker compose run alpine bash -c "./bin/restore-volumes ${BACKUP_DATE}"

# reset the docker environment
.PHONY: docker-reset
docker-reset:
	docker rm -f $$(docker ps -a -q); \
	docker rmi -f $$(docker images -q); \
	docker volume rm $$(docker volume ls -q); \
	docker system prune -f

# install cron jobs (schedule backup)
.PHONY: install-cron-jobs
install-cron-jobs:
	./bin/install-cron-jobs

# configure ssh config and keys
.PHONY: configure-ssh
configure-ssh:
	./bin/setup-ssh-keys

# set password
.PHONY: set-admin-password
set-admin-password:
	./bin/create-password

# setup host for this project
.PHONY: setup
setup: configure-ssh install-cron-jobs set-admin-password





