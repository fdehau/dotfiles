TMPL_VERSION = 0.3.0
TMPL_BASE_URL = https://github.com/fdehau/tmpl/releases/download/v$(TMPL_VERSION)
TMPL_ARCHIVE = tmpl-$(TARGET).tar.gz

$(BIN_DIR)/tmpl:
	@$(call download,$(TMPL_BASE_URL)/$(TMPL_ARCHIVE),$(TMPL_ARCHIVE))
	@tar xzvf $(TMPL_ARCHIVE)
	@mv tmpl $@
	@rm -rvf $(TMPL_ARCHIVE)

settings.json:
	echo '{"target": "$(TARGET)", "dotfiles_path": "$(ROOT_DIR)"}' > $@

define TEMPLATE
$(2): $(1) $(DOTFILES_CONFIG_PATH) settings.json $(BIN_DIR)/tmpl
	@mkdir -p $(dir $(2))
	@$(BIN_DIR)/tmpl $(DOTFILES_CONFIG_PATH) settings.json < $(1) > $(2)
	@$(call log_note,"Generated $(2) from $(1)")
endef
