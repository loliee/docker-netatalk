SHELL := /usr/bin/env bash
VERSION = 3.1.11
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

build: ## Build Image
	$(info --> Build image)
	docker build -t loliee/netatalk:$(VERSION) .

bundle-install: ## Run bundle install
	$(info --> run `bundle install`)
	@gem install bundler --quiet
	@bundle install

hadolint: ## Run hadolint
	$(info --> Run hadolint)
	@env PYTHONUNBUFFERED=1 \
		docker run --rm -i hadolint/hadolint:v1.6.2 hadolint --ignore=DL3008 - < Dockerfile

pre-commit: ## Run pre-commit tests
	$(info --> Run pre-commit)
	pre-commit run --all-files

serverspec: ## Run serverspec
	$(info --> Run serverspec)
	@env \
		SPEC_OPTS='--format documentation --color' \
		rake serverspec:run

shellcheck: ## Run shellcheck
	$(info --> Run shellcheck)
	@find . -name "*.sh" -type f | xargs -n 1 shellcheck

test: ## Run serverspec and pre-commit hooks
	$(info --> Run test suite)
	@make -j -l 3 hadolint pre-commit shellcheck serverspec
