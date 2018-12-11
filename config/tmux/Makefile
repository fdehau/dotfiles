
~/.tmux.conf: config/tmux/tmux.conf $(BIN_DIR)/tmpl
	@$(call gen_tmpl,$<,$@)
TMUX_OBJECTS += ~/.tmux.conf

$(BIN_DIR)/tmux: config/tmux/tmux
	@$(call log_note,"Building tmux...")
	@cd config/tmux/tmux && \
	  git checkout $(TMUX_VERSION) && \
	  sh autogen.sh && \
	  ./configure && \
	  $(MAKE)
	@cp config/tmux/tmux/tmux $@
TMUX_DIST_OBJECTS += $(BIN_DIR)/tmux

TMUX_URL="https://github.com/tmux/tmux"
TMUX_VERSION="2.8"
config/tmux/tmux:
	@$(call log_note,"Cloning tmux from $(TMUX_URL) to $@...")
	@git clone $(TMUX_URL) $@
TMUX_DIST_OBJECTS += config/tmux/tmux

~/.config/tmux/fzf-url.sh: config/tmux/fzf-url.sh
	@$(call copy_file,$<,$@)
	@chmod +x $@
TMUX_OBJECTS += ~/.config/tmux/fzf-url.sh
