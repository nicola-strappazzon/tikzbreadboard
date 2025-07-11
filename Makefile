SHELL := /bin/bash
GREEN := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
RESET := $(shell tput -Txterm sgr0)

.PHONY: help

help: ## Show this help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "${YELLOW}%-16s${GREEN}%s${RESET}\n", $$1, $$2}' $(MAKEFILE_LIST)

save: ## Save changes into repository automatically.
	@git add .
	@git commit -m "Save changes at: $$(date +%s)"
	@git push

run: ## Run hugo server in local.
	@hugo server --disableFastRender --noHTTPCache --ignoreCache --cleanDestinationDir

build: ## Create pdf and svg files from LaTex file using package circuitikz.
	@if [ -z "$(FILE)" ]; then \
		echo "Usage: make build FILE=example01"; \
		exit 1; \
	fi
	@pdflatex $(FILE).tex
	@pdf2svg $(FILE).pdf $(FILE).svg

clean: ## Remove build files.
	rm -f *.aux *.log *.dvi *.synctex.gz
