WEB_CONTAINER=schedule_api_web_1

.PHONY: build
build: ## Build docker containers
	@docker-compose build

.PHONY: new
new: ## Setup all
	@cp -n .env.example .env || true
	@pip install pre-commit
	@docker-compose up -d web
	@make update
	@make dialyzer
	@make db-create
	@make db-migrate

.PHONY: logs
logs:
	@docker-compose logs -f

.PHONY: update
update: # Update dependencies
	@docker-compose exec web mix do deps.get, deps.compile

.PHONY: db-create
db-create: ## Create database
	@docker-compose exec web mix ecto.create

.PHONY: db-migrate
db-migrate: ## Migrate database
	@docker-compose exec web mix ecto.migrate

.PHONY: up
up: ## Create and start containers
	@docker-compose up -d

.PHONY: down
down: ## Stop and remove containers and networks
	@docker-compose down

.PHONY: test
test: ## Execute PHPUnit tests
	@docker-compose exec web mix test $(filter-out $@,$(MAKECMDGOALS))

.PHONY: test-ci
test-ci:
	@docker exec -t $(WEB_CONTAINER) mix test $(filter-out $@,$(MAKECMDGOALS))

.PHONY: shell
shell: ## Open a shell in the web container
	@docker-compose exec web sh

.PHONY: repl
repl:
	@docker-compose exec web iex

lint:
	@docker exec -t $(WEB_CONTAINER) mix do format, credo --strict $(filter-out $@,$(MAKECMDGOALS))

.PHONY: dialyzer
dialyzer:
	@docker-compose exec -T web mix dialyzer --halt-exit-status

# this is a hack to allow us to pass args to make targets
%:
	@:
