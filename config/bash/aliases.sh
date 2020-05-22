# git
alias gco='git co $(git br --list --color=never | tr -s " " | cut -d" " -f2 | fzf-tmux)'
alias gbrd='git br -d $(git br --list | fzf-tmux)'
alias magit='nvim +MagitOnly'

# kuberneters
alias k="kubectl"

# Reload .bashrc
alias refresh='source ~/.bashrc'

# And one because I always mistype it
alias sl="ls"

alias cl="clear"

# Open quickly ypur favorite editor
alias e="nvim"

# Open your neovim config
alias evc="nvim ~/.config/nvim/init.vim"

# Update the neovim config
alias uvc="nvim +PlugUpgrade +PlugUpdate"

# Open your bash config
alias ebc="nvim ~/.bashrc"

# ssh
alias ssh="TERM=xterm-256color ssh"

# Move, copy and remove files interactively
alias mv="mv -i"
alias rm="rm -i"
alias cp="cp -i"

alias ".."="cd .."
alias "..."="cd ../.."
alias "...."="cd ../../.."

alias ":q"="exit"
alias "bye"="exit"
alias "byebye"="shutdown -h now"
