.DEFAULT_GOAL := help

.PHONY: help
help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $1, $2}'

.PHONY: test
test:
	pdm run pytest -n auto tests -ra

.PHONY: test-unit
test-unit:
    @read -p "Enter bounded context: " BOUNDED_CONTEXT; \
    pdm run pytest -n auto tests/$$BOUNDED_CONTEXT/application -ra

.PHONY: test-integration
test-integration:
    pdm run pytest -n auto tests/bounded_context/infra -ra

.PHONY: test-acceptance
test-acceptance:
    pdm run pytest -n auto tests/bounded_context/delivery -ra

.PHONY: coverage
coverage:
	pdm run coverage run --branch -m pytest tests
	pdm run coverage html
	@open "${PWD}/htmlcov/index.html"

.PHONY: local-setup
local-setup:
	scripts/local-setup.sh
	make install

.PHONY: install
install:
    rm -rf pdm.lock
	pdm install

.PHONY: update
update:
	pdm update

.PHONY: add-dependency
add-dependency:
	@read -p "Dependency to install: " PACKAGE_NAME; \
	pdm add $$PACKAGE_NAME

.PHONY: check-typing
check-typing:
	pdm run mypy .

.PHONY: style
style:
    pdm run yapf -r -i src tests

.PHONY: pre-commit
pre-commit:
    check-typing style test-unit

.PHONY: pre-push
pre-push:
    test-integration test-acceptance

.PHONY: rename-project
rename-project:
    @read -p "Enter the new project name: " NAME; \
	sed -i 's/python-template/$NAME/' Makefile
	sed -i 's/python-template/$NAME/' pyproject.toml

.PHONY: rename-context
rename-context:
    @read -p "Enter bounded context to rename: " CURRENT_BOUNDED_CONTEXT; \
    @read -p "Enter new bounded context name: " NEW_BOUNDED_CONTEXT; \
    sed -i 's/$$CURRENT_BOUNDED_CONTEXT/$$NEW_BOUNDED_CONTEXT/' Makefile
