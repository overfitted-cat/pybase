# Template base Python project

This template contains most of the stuff you might need for a Python project.

## How to initialize
1. Make a new repo and use this one as a template (Follow how to marge changes section below)
2. Create your project package directory
3. Add project package name to the `project-packages.txt`
4. Set virtualenv (if you want to create directory for env inside project directory make sure to make it hidden, with `.`, like e.g. `.my-env` that way it won't trigger MyPy validation on dependecies). I used 3.10, but should be fine with 3.7+.
5. Run `make install-test`
6. (Optional) - Copy [https://github.com/overfitted-cat/pybase/blob/main/.vscode-settings/settings.json](settings.json) into `.vscode/settgins.json`
7. (Optional) - Set env for the vscode
8. (Optional) - Set github hooks, e.g. add `make docker-validate` in `.git/hooks/pre-commit` - This will run docker build, ptest, isort, mypy, flake8 and safety validations.

## How to merge changes
You can synchronize all your repoes with this base by setting:
1. `git remote add base git@github.com:overfitted-cat/pybase.git` - this need to be ran once, it sets another remote (`base`) to point to this template
2. (Optional) - `git remote -v` - One of the outputs should be `base	git@github.com:overfitted-cat/pybase.git (fetch)`
3. `git fetch base` - this will fetch all new commits from this template repo
4. `git merge --no-ff base/main --allow-unrelated-histories` 
5. `git config remote.base.pushurl "Push to the template repo is not allowed"` - just to make sure you don't update the template repo from your repo

## Makefile commands
1. `make install` - installs a project with dependecies 
2. `make install-test` - installs dev version with dependecies to validation and test
3. `make run-test`- Runs all tests from `tests`
4. `make validate` - Runs `mypy`, `flake8`, `isort` and `safety` checks
5. `make coverage` - Generates coverage HTML report
6. `make run-test-full` - Runs tests + validations
7. `make run-docker-validate` - Runs validation and tests inside the docker container
