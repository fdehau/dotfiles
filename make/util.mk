# Copy a file from a source location to its destination
# $(1): source
# $(2): destination
copy_file = if [[ ! -d $(dir $(2)) ]]; then mkdir -p $(dir $(2)); $(call log_note,"Created $(dir $(2))"); fi;\
  cp $(1) $(2); $(call log_note,"Copied $(1) to $(2)")

# Generate a file using tmpl based on the loaded colorscheme and configuration
tmpl = $(BIN_DIR)/tmpl $(DOTFILES_CONFIG_PATH) < $(1) > $(2)

# Generate a file using tmpl
# $(1): source
# $(2): destination
gen_tmpl = if [[ ! -d $(dir $(2)) ]]; then mkdir -p $(dir $(2)); $(call log_note,"Created $(dir $(2))"); fi;\
  $(call tmpl,$(1),$(2)); $(call log_note,"Generated $(2) from $(1)")

# Uppercase transformation for a string
uppercase = $(shell echo $(1) | tr a-z A-Z)

download = $(call log_note,"Downloading $(2) from $(1)"); curl --create-dirs -fLo $(2) $(1);

clone = $(call log_note,"Cloning $(2) from $(1)"); git clone $(1) $(2) --depth 1;
