WORKING_DIR := $(shell pwd)
CHART_VERSION := $(shell helm local-chart-version get --chart .)

.DEFAULT_GOAL := docker-test

.PHONY: build push

go-deps:: ## fetch all the go dependencies for local development
		go get ./test/...

test:: ## Runs the tests in golang
		go test -v ./test/...

docs:: ## Builds the README.md for charts
		helm-docs
		# sed "s/CHART_VERSION/$(CHART_VERSION)/g" README.md.gotmpl > README.md

deploy:: ## Builds and publishes a chart
		rm -fr .deploy && mkdir .deploy
		helm3 package . --destination .deploy/
		cr upload -o seanson -r charts-buildkite-metrics-agent -p .deploy --token "$$CH_TOKEN"

bump-patch:: ## Bumps the charts a patch version
		helm local-chart-version bump --chart . --version-segment patch
		make docs

bump-minor:: ## Bumps the charts a minor version
		helm local-chart-version bump --chart . --version-segment minor
		make docs

bump-major:: ## Bumps the charts a major version
		helm local-chart-version bump --chart . --version-segment major
		make docs

docker-test:: ## Runs the Terratest docker image
		@docker run -v ${PWD}:/app/test -t -i seanson/terratest-helm-tester:latest ./test/...

# a help target including self-documenting targets (see the awk statement)
define HELP_TEXT
Usage: make [TARGET]... [MAKEVAR1=SOMETHING]...

Available targets:
endef
export HELP_TEXT
help: ## this help target
	@cat .banner
	@echo
	@echo "$$HELP_TEXT"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[36m%-30s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)
