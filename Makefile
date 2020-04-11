# Check config path and load it
DOTFILES_CONFIG_PATH = $(HOME)/.config/dotfiles/config.json

# No built-in rules
MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

# Less output
MAKEFLAGS += --no-print-directory

# Global variables
SHELL = /bin/bash
HOSTNAME = $(shell hostname)
ROOT_DIR = $(shell pwd)
BIN_DIR = ~/.local/bin
CONFIG_DIR = $(ROOT_DIR)/config
MAKE_DIR = $(ROOT_DIR)/make

ifeq ($(OS),Windows_NT)
  TARGET = x86_64-pc-windows-msvc
else
  UNAME = $(shell uname -s)
  ifeq ($(UNAME),Darwin)
    TARGET = x86_64-apple-darwin
  else ifeq ($(UNAME),Linux)
    TARGET = x86_64-unknown-linux-gnu
  else
    $(error "Failed to detect os")
  endif
endif

include make/colors.mk
include make/log.mk
include make/util.mk
include make/tmpl.mk

# Components
COMPONENTS_DIRS = $(shell find $(CONFIG_DIR) -mindepth 1 -maxdepth 1 -type d)
COMPONENTS = $(patsubst $(CONFIG_DIR)/%,%,$(COMPONENTS_DIRS))

# Help
.PHONY: help
help: ## Print help
	@echo -e "$(ANSI_CYAN)$(ANSI_BOLD)"
	@cat $(MAKE_DIR)/banner.txt
	@echo -e "$(ANSI_RESET)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "$(ANSI_BLUE)%-30s$(ANSI_RESET) %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: install
install: ## Build binaries, copy and generate configuration files

.PHONY: update
update: ## Update all components (for example update neovim plugins)

.PHONY: clean
clean: ## Remove configuration files but keep downloaded files

.PHONY: distclean
distclean: ## Remove configuration files and downloaded files
	@rm -f $(BIN_DIR)/tmpl
	@$(call log_info,"Removed $(BIN_DIR)/tmpl")

# Macro used to define the hooks required to manage a dotfiles' component (ie
# install, clean, ...)
define COMPONENT

# Store the uppercase name of the component inside a variable
$(eval $(1)_NAME := $(call uppercase,$(1)))
$($(1)_NAME)_OBJECTS =
$($(1)_NAME)_DIST_OBJECTS =

# Define the install rule
.PHONY: install-$(1)
install-$(1): $($($(1)_NAME)_OBJECTS) $($($(1)_NAME)_DIST_OBJECTS)
	@$(call log_info,"Finished installation of $(1)")

install: install-$(1)

# Define the update rule
.PHONY: update-$(1)
update: update-$(1)

# Define the clean rule
.PHONY: clean-$(1)
clean-$(1):
	@for o in $($($(1)_NAME)_OBJECTS); do rm -f $$$$o; $(call log_note,"Removed $$$$o"); done;
	@$(call log_info,"Finished cleaning of $(1)")

clean: clean-$(1)

# Define the dist clean rule
.PHONY: distclean-$(1)
distclean-$(1):
	@for o in $($($(1)_NAME)_DIST_OBJECTS); do rm -rf $$$$o; $(call log_note,"Removed $$$$o"); done;
	@$(call log_info,"Finished cleaning of $(1)")

distclean: distclean-$(1) clean-$(1)

endef

# Register components
$(foreach component_dir,$(COMPONENTS_DIRS),$(eval include $(component_dir)/Makefile))
$(foreach component,$(COMPONENTS),$(eval $(call COMPONENT,$(component))))

.DEFAULT_GOAL := help
