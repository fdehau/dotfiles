FUNCTIONS = $(wildcard config/fish/functions/*.fish)
~/.config/fish/functions/%: config/fish/functions/%
	@$(call copy_file,$<,$@)
FISH_OBJECTS += $(patsubst config/fish/functions/%,~/.config/fish/functions/%,$(FUNCTIONS))

CONFIGS = $(wildcard config/fish/conf.d/*.fish)
~/.config/fish/conf.d/%: config/fish/conf.d/%
	@$(call copy_file,$<,$@)
FISH_OBJECTS += $(patsubst config/fish/conf.d/%,~/.config/fish/conf.d/%,$(CONFIGS))
