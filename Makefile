#!/usr/bin/env make -f

# Find all PY files except those in hidden folders. TODO: make this list extendable
FILES_PY = $(shell find $(CURDIR) -type f -name "*.py" -not -path "$(CURDIR)/.**/**" -not -path "$(CURDIR)/build/**")

install:
	python -m pip install -e . && \
	python setup.py build_ext --inplace

install-test:
	pip install -e . && \
	pip install -r $(CURDIR)/tests/requirements.txt && \
	python setup.py build_ext --inplace

run-test:
	@pytest $(CURDIR)/tests/ -vv --color=yes || [ $$? -eq 5 ] && exit 0 || exit $$?

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
	@python setup.py bdist_wheel

coverage:
	@pytest --cov-report=html --cov=$(CURDIR)/tests/ -vv --color=yes || [ $$? -eq 5 ] && exit 0 || exit $$?

run-test-full: validate run-test

docker-validate:
	@docker build -t test-build --build-arg ENV=TEST $(CURDIR)
	@docker run --rm --entrypoint /usr/bin/make test-build:latest run-test-full
	@docker image rm test-build
