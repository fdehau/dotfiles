
~/.config/i3blocks/config: config/i3blocks/config
	@$(call copy_file,$<,$@)
I3BLOCKS_OBJECTS += ~/.config/i3blocks/config

I3BLOCKS_SOURCES = $(shell find config/i3blocks/blocks -type f)
I3BLOCKS_OBJECTS += $(patsubst config/i3blocks/blocks/%,~/.config/i3blocks/blocks/%,$(I3BLOCKS_SOURCES))
~/.config/i3blocks/blocks/%: config/i3blocks/blocks/%
	@$(call copy_file,$<,$@)
