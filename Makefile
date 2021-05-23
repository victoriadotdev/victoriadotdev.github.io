SHELL := /bin/bash
.POSIX:
.PHONY: help env install upgrade-hugo lint serve build start initial

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

DATEOF:=$(shell date +%FT%T)

article: ## Create frontmatter for a new article
	printf '%b\n' "---\ntitle: $(shell uuidgen) \ndate: $(DATEOF) \ncategories: ["article"] \ntags: \n---\n\n" > posts/$(DATEOF).md
	touch posts/$(DATEOF).md

a: ## Create file and frontmatter for a NEW=...
	@printf '%b\n' "---\ntitle: $(shell uuidgen)\ndate: $(DATEOF)\ncategories: [\"$(NEW)\"]\ntags: \n---\n\n" > neofeed/$(DATEOF).md
	touch neofeed/$(DATEOF).md

lint: ## Lint files
	pre-commit run --all-files
