SUBMODULE_PATH := templates/rime-config

.PHONY: submodule-update submodule-update-commit submodule-sync

# Update submodule to latest remote commit (no commit in parent repo)
submodule-update:
	@echo "Updating submodule (no commit): $(SUBMODULE_PATH)"
	@git submodule update --remote -- $(SUBMODULE_PATH)
	@git status --short $(SUBMODULE_PATH)

# Update submodule and commit the pointer change in parent repo
submodule-update-commit:
	@echo "Updating submodule and committing: $(SUBMODULE_PATH)"
	@git submodule update --remote -- $(SUBMODULE_PATH)
	@if git diff --quiet -- $(SUBMODULE_PATH); then \
		echo "Submodule already up to date. Nothing to commit."; \
	else \
		git add $(SUBMODULE_PATH); \
		git commit -m "chore: update submodule $(SUBMODULE_PATH)"; \
		echo "Submodule updated and committed."; \
	fi

# Sync submodules to the commits recorded in the parent repository
submodule-sync:
	@echo "Syncing submodules to recorded commits"
	@git submodule update --init --recursive
