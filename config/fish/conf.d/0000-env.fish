fish_add_path -P /opt/homebrew/bin
fish_add_path -P ~/.cargo/bin
fish_add_path -P ~/.local/bin

set -gx EDITOR nvim

# FZF
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
set -gx FZF_CTRL_T_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
