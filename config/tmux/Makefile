$(eval $(call TEMPLATE,config/tmux/tmux.conf,~/.tmux.conf))
TMUX_OBJECTS += ~/.tmux.conf

~/.config/tmux/fzf-url.sh: config/tmux/fzf-url.sh
	@$(call copy_file,$<,$@)
	@chmod +x $@
TMUX_OBJECTS += ~/.config/tmux/fzf-url.sh
