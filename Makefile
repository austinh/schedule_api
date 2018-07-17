.PHONY: build
build: ## Build docker containers
	docker-compose build

.PHONY: new
new: ## Setup all
	cp -n .env.example .env || true
	curl https://pre-commit.com/install-local.py | python -
	docker-compose up -d web
	make update
	make dialyzer
	make db-create
	make db-migrate

.PHONY: update
update: # Update dependencies
	docker-compose exec web mix do deps.get, deps.compile

.PHONY: db-create
db-create: ## Create database
	docker-compose exec web mix ecto.create

.PHONY: db-migrate
db-migrate: ## Migrate database
	docker-compose exec web mix ecto.migrate

.PHONY: up
up: ## Create and start containers
	docker-compose up

.PHONY: down
down: ## Stop and remove containers and networks
	docker-compose down

.PHONY: test
test: ## Execute PHPUnit tests
	docker-compose exec web mix test

.PHONY: shell
shell: ## Open a shell in the web container
	docker-compose exec web sh

.PHONY: repl
repl:
	docker-compose exec web iex

lint:
	docker-compose exec web mix do format, credo --strict

.PHONY: dializer
dialyzer:
	docker-compose exec web mix dialyzer
