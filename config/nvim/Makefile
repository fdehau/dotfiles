NVIM_CONFIG_DIR = ~/.config/nvim

# Neovim config file
$(NVIM_CONFIG_DIR)/init.lua: config/nvim/init.lua
	@$(call copy_file,$<,$@)

NVIM_OBJECTS += $(NVIM_CONFIG_DIR)/init.lua

$(NVIM_CONFIG_DIR)/lazy-lock.json: config/nvim/lazy-lock.json
	@$(call copy_file,$<,$@)

NVIM_OBJECTS += $(NVIM_CONFIG_DIR)/lazy-lock.json

.PHONY: update-nvim-plugins
update-nvim-plugins:
	@$(call copy_file,$(NVIM_CONFIG_DIR)/lazy-lock.json,config/nvim/lazy-lock.json)
