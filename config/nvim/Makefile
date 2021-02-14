NVIM_CONFIG_DIR = ~/.config/nvim
NVIM_VERSION = $(shell nvim --version | head -n 1 | sed 's/^NVIM v\([0-9]*\.[0-9]*\.[0-9]*\).*$$/\1/')
NVIM_PACK_PATH = ~/.local/share/nvim/site/pack

# Neovim config file
$(NVIM_CONFIG_DIR)/init.vim: config/nvim/init.vim
	@$(call copy_file,$<,$@)
$(NVIM_CONFIG_DIR)/init.lua: config/nvim/init.lua
	@$(call copy_file,$<,$@)

# 0.4.0: Plugins are managed using vim-plug
VIM_PLUG_URL = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
$(NVIM_CONFIG_DIR)/autoload/plug.vim:
	@$(call download,$(VIM_PLUG_URL),$@)
# 0.5.0: Plugins are managed using packer.nvim
VIM_PACKER_URL = "https://github.com/wbthomason/packer.nvim"
$(NVIM_PACK_PATH)/packer/opt/packer.nvim:
	@$(call clone,$(VIM_PACKER_URL),$@)

ifeq ("$(NVIM_VERSION)","0.5.0")
  NVIM_OBJECTS += $(NVIM_CONFIG_DIR)/init.lua
  NVIM_DIST_OBJECTS += $(NVIM_PACK_PATH)/packer/opt/packer.nvim
else
  NVIM_OBJECTS += $(NVIM_CONFIG_DIR)/init.vim
  NVIM_DIST_OBJECTS += $(NVIM_CONFIG_DIR)/autoload/plug.vim
endif

update-nvim:
	@$(call log_note,"Updating neovim python package")
	@python3 -m pip install --user --upgrade neovim
	@$(call log_note,"Updating vim-plug and plugins")
	@nvim +PlugUpgrade +PlugUpdate
	@$(call log_info,"Finished updating neovim")
