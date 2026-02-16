SHELL := /bin/zsh

.PHONY: link install defaults all

link:
	@zsh ./shell/link.sh

install:
	@zsh ./shell/install.sh

defaults:
	@zsh ./shell/defaults.sh

all: link install defaults
