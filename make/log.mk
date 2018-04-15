log = echo -e "$(1)$(ANSI_BOLD)$(ANSI_INVERT) $(2) $(ANSI_RESET) $(3)"
log_note = $(call log,$(ANSI_GRAY),"NOTE",$(1))
log_info = $(call log,$(ANSI_GREEN),"INFO",$(1))
log_warn = $(call log,$(ANSI_YELLOW),"WARN",$(1))
log_fail = $(call log,$(ANSI_RED),"FAIL",$(1))
