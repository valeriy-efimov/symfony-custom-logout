THIS_FILE := $(lastword $(MAKEFILE_LIST))
.PHONY: help build up bash down kill
help:
	make -pRrq  -f $(THIS_FILE) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
build:
	docker compose -f docker-compose.yml --env-file ./.env.local build $(c)
up:
	docker compose -f docker-compose.yml --env-file ./.env.local up -d $(c)
bash:
	docker compose -f docker-compose.yml exec php /bin/bash
down:
	docker compose -f docker-compose.yml down $(c)
kill:
	docker kill $$(docker ps -q)