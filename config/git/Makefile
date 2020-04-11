$(eval $(call TEMPLATE,config/git/gitconfig,~/.gitconfig))
GIT_OBJECTS += ~/.gitconfig

~/.gitmessage: config/git/gitmessage
	@$(call copy_file,$<,$@)
GIT_OBJECTS += ~/.gitmessage

~/.gitignore: config/git/gitignore
	@$(call copy_file,$<,$@)
GIT_OBJECTS += ~/.gitignore
