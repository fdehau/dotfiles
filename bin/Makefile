BINS += bin/background
BINS += bin/brightness
BINS += bin/colorlog
BINS += bin/screengif
BINS += bin/background

~/.local/bin/%: bin/%
	@$(call copy_file,$<,$@)

BIN_OBJECTS += $(patsubst bin/%,~/.local/bin/%,$(BINS))

$(eval $(call COMPONENT,bin))
