$(eval $(call TEMPLATE,config/bash/bashrc,~/.bashrc))
BASH_OBJECTS += ~/.bashrc

~/.bash_profile: config/bash/bash_profile
	@$(call copy_file,$<,$@)
BASH_OBJECTS += ~/.bash_profile

BASH_CONFIG_FILES = \
  config/bash/fns.sh \
  config/bash/aliases.sh \
  config/bash/aliases.linux.sh \
  config/bash/aliases.darwin.sh \
  config/bash/prompt.sh
BASH_OBJECTS += $(patsubst config/bash/%,~/.config/bash/%,$(BASH_CONFIG_FILES))
~/.config/bash/%: config/bash/%
	@$(call copy_file,$<,$@)

Z_URL = https://raw.githubusercontent.com/rupa/z/master/z.sh
~/.config/bash/z.sh:
	@$(call download,$(Z_URL),$@)
BASH_DIST_OBJECTS += ~/.config/bash/z.sh
