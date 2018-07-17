.PHONY: build
build: ## Build docker containers
	@docker-compose build

.PHONY: new
new: ## Setup all
	@cp -n .env.example .env || true
	@docker-compose up -d web
	@make update
	@make db-create
	@make db-migrate

.PHONY: update
update: # Update dependencies
	@docker-compose exec web mix deps.get

.PHONY: db-create
db-create: ## Create database
	@docker-compose exec web mix ecto.create

.PHONY: db-migrate
db-migrate: ## Migrate database
	@docker-compose exec web mix ecto.migrate

.PHONY: up
up: ## Create and start containers
	@docker-compose up

.PHONY: down
down: ## Stop and remove containers and networks
	@docker-compose down

.PHONY: test
test: ## Execute PHPUnit tests
	@docker-compose exec web mix test

.PHONY: shell
shell: ## Open a shell in the web container
	@docker-compose exec web bash

.PHONY: repl
repl:
	@docker-compose exec web iex

dev-server:
	@docker-compose exec web iex -S mix phx.server
