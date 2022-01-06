#!/usr/bin/env make -f

IGNORES =
IGNORES += "$(CURDIR)/.*"
# Add ignores below like IGNORES += "pattern"

# Add ignores above
EMPTY:=
SPACE:=$(EMPTY) $(EMPTY)
IGNORES_ARGS = $(subst ${SPACE}, -not -path ,${IGNORES})

FILES_PY = $(shell find $(CURDIR) -type f -name "*.py" $(IGNORES_ARGS))

install:
	python -m pip install -e . && \
	python setup.py build_ext --inplace

install-test:
	pip install -e . && \
	pip install -r $(CURDIR)/tests/requirements.txt && \
	python setup.py build_ext --inplace

run-test:
	@pytest $(CURDIR)/tests/ -vv --color=yes

validate:
	@echo "Running flake8"
	@flake8 $(FILES_PY)
	@echo "Running mypy"
	@mypy $(FILES_PY)
	@echo "Running isort"
	@isort -c $(FILES_PY)
	@echo "Running safety"
	@safety check --bare

build-package:
	@python -m build

coverage:
	@pytest --cov-report=html --cov=$(CURDIR)/tests/ -vv --color=yes

run-test-full:
	validate
	run-test
	coverage

docker-validate:
	@docker build -t test-build $(CURDIR)
	@docker run --exec --rm test-build:latest make run-test-full

echo-files-debug:
	@echo "ignore args"
	@echo $(IGNORES_ARG)
	@echo "find command"
	@echo "shell find $(CURDIR) -type f -name "*.py" $(IGNORES_ARG)"
	@echo "all files"
	@echo $(FILES_PY)
