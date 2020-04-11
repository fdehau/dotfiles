ST_VERSION = 0.8.2
ST_DIR = st-$(ST_VERSION)
ST_ARCHIVE = $(ST_DIR).tar.gz
ST_URL = https://dl.suckless.org/st/$(ST_ARCHIVE)

$(eval $(call TEMPLATE,config/st/config.h,config/st/$(ST_DIR)/config.h))
ST_OBJECTS += config/st/$(ST_DIR)/config.h

config/st/.download:
	@$(call download,$(ST_URL),config/st/$(ST_ARCHIVE))
	@cd config/st && \
	  tar -xzvf $(ST_ARCHIVE) && \
	  rm -f $(ST_ARCHIVE)
	@touch $@
ST_DIST_OBJECTS += config/st/$(ST_DIR) config/st/.download

$(BIN_DIR)/st: MAKEFLAGS =
$(BIN_DIR)/st: config/st/.download config/st/$(ST_DIR)/config.h
	@$(call log_note,"Building st...")
	$(MAKE) -C config/st/$(ST_DIR)
	@cp config/st/$(ST_DIR)/st $@
ST_DIST_OBJECTS += $(BIN_DIR)/st

config/st/.tic: config/st/.download
	@$(call log_note,"Compiling terminfo...")
	@tic -sx config/st/$(ST_DIR)/st.info
	@touch $@
ST_OBJECTS += config/st/.tic
