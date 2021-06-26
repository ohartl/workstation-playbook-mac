# Called without arguments Make prints the help.
.DEFAULT_GOAL := help

PYTHON_VERSION ?= 3.9
ANSIBLE_VERSION ?= 2.10

### Targets

.PHONY: run
run: ## Run ansible playbook
	@ansible-playbook main.yml

.PHONY: setup
setup: ## Setup ansible playbook
	@echo "Wipe vendor dir" \
		&& rm -rf ${PWD}/vendor
	@echo "Check for python" \
		&& which python > /dev/null || (echo "Python not found" && exit 1)
	@echo "Check for ansible" \
		&& which ansible > /dev/null || (echo "Ansible not found" && exit 1)
	@echo "Setup ansible requirements.yml" \
		&& ansible-galaxy install -r ${PWD}/requirements.yml

.PHONY: help
help: ## Print this help
	@if [ -t 1 ] ; then \
		grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'; \
	else \
		grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'; \
	fi
