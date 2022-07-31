
# paths
fish_add_path -P /opt/homebrew/bin
fish_add_path -P ~/.cargo/bin
fish_add_path -P ~/.local/bin

# editor
set -gx EDITOR nvim

# fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
set -gx FZF_CTRL_T_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'

# bat
if is_dark_mode
    set -gx BAT_THEME 'gruvbox-dark'
else
    set -gx BAT_THEME 'gruvbox-light'
end
