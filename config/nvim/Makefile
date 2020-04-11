NVIM_CONFIG_DIR = ~/.config/nvim

# Neovim config file
$(NVIM_CONFIG_DIR)/init.vim: config/nvim/init.vim
	@$(call copy_file,$<,$@)
NVIM_OBJECTS += $(NVIM_CONFIG_DIR)/init.vim

# Plugins are managed using vim-plug by junegunn
VIM_PLUG_URL = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
$(NVIM_CONFIG_DIR)/autoload/plug.vim:
	@$(call download,$(VIM_PLUG_URL),$@)
NVIM_DIST_OBJECTS += $(NVIM_CONFIG_DIR)/autoload/plug.vim

update-nvim:
	@$(call log_note,"Updating neovim python package")
	@python3 -m pip install --user --upgrade neovim
	@$(call log_note,"Updating vim-plug and plugins")
	@nvim +PlugUpgrade +PlugUpdate
	@$(call log_info,"Finished updating neovim")
