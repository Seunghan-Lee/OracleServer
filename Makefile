.PHONY: help up down deploy-wp db-pull docker-login

help:
	@echo "Available targets:"
	@echo "  make up stack=STACK   # docker compose up for STACK (peterosea-wp|heworks-blog|openclaw)"
	@echo "  make down stack=STACK # docker compose down"
	@echo "  make deploy-wp stack=STACK # run remote deploy workflow"
	@echo "  make db-pull stack=STACK # pull DB dump from server"

STACK?=peterosea-wp
DC=docker compose --env-file oci-os/docker/$(STACK)/.env -f oci-os/docker/$(STACK)/docker-compose.yml

up:
	$(DC) up -d

down:
	$(DC) down

deploy-wp:
	./scripts/deploy.sh $(STACK)

db-pull:
	./scripts/db-sync.sh pull $(STACK)
