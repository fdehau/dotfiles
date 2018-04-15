TMPL_VERSION = 0.1.1
TMPL_BASE_URL = https://github.com/fdehau/tmpl/releases/download/v$(TMPL_VERSION)
TMPL_DIR = tmpl-v$(TMPL_VERSION)-x86_64-unknown-linux-gnu
TMPL_ARCHIVE = $(TMPL_DIR).tar.gz

$(BIN_DIR)/tmpl:
	$(call log_info,"Downloading tmpl $(TMPL_VERSION)...")
	@curl -fLo $(TMPL_ARCHIVE) $(TMPL_BASE_URL)/$(TMPL_ARCHIVE)
	@tar xzvf $(TMPL_ARCHIVE)
	@cp $(TMPL_DIR)/tmpl $@
	@rm -rvf $(TMPL_DIR) $(TMPL_ARCHIVE)
