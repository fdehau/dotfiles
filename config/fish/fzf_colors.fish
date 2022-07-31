if is_dark_mode
    set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color=fg:{{ colors.white }},bg:{{ colors.black }},hl:{{ colors.blue }},fg+:{{ colors.white }},bg+:{{ colors.black }},hl+:{{ colors.bright_blue }},info:{{ colors.cyan }},prompt:{{ colors.red }},pointer:{{ colors.red }},marker:{{ colors.red }},spinner:{{ colors.bright_cyan }},header:{{ colors.white }}"
else
    set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color=fg:{{ light_colors.white }},bg:{{ light_colors.black }},hl:{{ light_colors.blue }},fg+:{{ light_colors.white }},bg+:{{ light_colors.black }},hl+:{{ light_colors.bright_blue }},info:{{ light_colors.cyan }},prompt:{{ light_colors.red }},pointer:{{ light_colors.red }},marker:{{ light_colors.red }},spinner:{{ light_colors.bright_cyan }},header:{{ light_colors.white }}"
end
