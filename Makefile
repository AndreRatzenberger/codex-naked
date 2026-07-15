PREFIX ?= $(HOME)/.local
BINDIR ?= $(PREFIX)/bin

.PHONY: all check test lint install uninstall

all: check

check: lint test

test:
	bash test/codex-naked-test.sh

lint:
	bash -n bin/codex-naked
	bash -n test/codex-naked-test.sh
	sh -n install.sh
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck bin/codex-naked test/codex-naked-test.sh install.sh; \
	else \
		echo "shellcheck not found; skipped"; \
	fi

install:
	install -d "$(BINDIR)"
	install -m 755 bin/codex-naked "$(BINDIR)/codex-naked"

uninstall:
	rm -f "$(BINDIR)/codex-naked"
