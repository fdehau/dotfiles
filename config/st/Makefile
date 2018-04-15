ST_VERSION = 0.7
ST_DIR = st-$(ST_VERSION)
ST_ARCHIVE = $(ST_DIR).tar.gz
ST_URL = https://dl.suckless.org/st/$(ST_ARCHIVE)

config/st/$(ST_DIR)/config.h: config/st/config $(BIN_DIR)/tmpl | config/st/$(ST_DIR)
	@$(call gen_tmpl,$<,$@)
ST_OBJECTS += config/st/$(ST_DIR)/config.h

config/st/$(ST_DIR):
	@$(call log_note,"Downloading st...")
	@curl -fLo config/st/$(ST_ARCHIVE) $(ST_URL)
	@cd config/st && \
	  tar -xzvf $(ST_ARCHIVE) && \
	  rm -f $(ST_ARCHIVE)
ST_DIST_OBJECTS += config/st/$(ST_DIR)

$(BIN_DIR)/st: MAKEFLAGS =
$(BIN_DIR)/st: config/st/$(ST_DIR)/config.h
	@$(call log_note,"Building st...")
	@cd config/st/$(ST_DIR) && $(MAKE)
	@cp config/st/$(ST_DIR)/st $@
ST_DIST_OBJECTS += $(BIN_DIR)/st
