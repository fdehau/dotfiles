NVIM_CONFIG_DIR = ~/.config/nvim
NVIM_PACK_PATH = ~/.local/share/nvim/site/pack

# Neovim config file
$(NVIM_CONFIG_DIR)/init.lua: config/nvim/init.lua
	@$(call copy_file,$<,$@)

# Plugins are managed using packer.nvim
VIM_PACKER_URL = "https://github.com/wbthomason/packer.nvim"
$(NVIM_PACK_PATH)/packer/opt/packer.nvim:
	@$(call clone,$(VIM_PACKER_URL),$@)

NVIM_OBJECTS += $(NVIM_CONFIG_DIR)/init.lua
NVIM_DIST_OBJECTS += $(NVIM_PACK_PATH)/packer/opt/packer.nvim
