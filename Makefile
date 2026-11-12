SHELL := /bin/zsh

.PHONY: check link install defaults skills-check skills-update all

check:
	@zsh ./shell/check.sh

link:
	@zsh ./shell/link.sh

install: link
	@zsh ./shell/install.sh

defaults:
	@zsh ./shell/defaults.sh

skills-check:
	@zsh ./shell/update-skills.sh --check

skills-update:
	@zsh ./shell/update-skills.sh --sync

all: install
	@$(MAKE) defaults
