~/.bashrc: config/bash/bashrc $(DOTFILES_BASH_PROFILE)
	@cp $< $@
	@echo "" >> $@
	@echo "# Source custom profile" >> $@
	@echo "source $(DOTFILES_BASH_PROFILE)" >> $@
	@$(call log_note,"Generated $@ from $<")
BASH_OBJECTS += ~/.bashrc

~/.bash_profile: config/bash/bash_profile
	@$(call copy_file,$<,$@)
BASH_OBJECTS += ~/.bash_profile

BASH_CONFIG_FILES = \
  config/bash/fns.sh \
  config/bash/aliases.sh \
  config/bash/prompt.sh
BASH_CONFIG_FILES += $(shell find config/bash/components -type f)
BASH_OBJECTS += $(patsubst config/bash/%,~/.bash/%,$(BASH_CONFIG_FILES))
~/.bash/%: config/bash/%
	@$(call copy_file,$<,$@)

Z_URL = https://raw.githubusercontent.com/rupa/z/master/z.sh
~/.bash/z.sh:
	@$(call log_note,"Downloading z from $(Z_URL) to $@...")
	@curl -fLo $@ --create-dirs $(Z_URL)
BASH_DIST_OBJECTS += ~/.bash/z.sh
