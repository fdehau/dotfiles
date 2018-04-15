# git
alias gco='git co $(git br --list --color=never | tr -s " " | cut -d" " -f2 | fzf-tmux)'
alias gbrd='git br -d $(git br --list | fzf-tmux)'
alias magit='nvim +MagitOnly'

# apt
alias apti="sudo apt-get install"
alias aptr="sudo apt-get remove"
alias apts="apt-cache search"
alias aptsn="apt-cache search --names-only"
alias aptu="sudo apt-get update"
alias aptuu="sudo apt-get update && sudo apt-get upgrade"

# Reload .bashrc
alias refresh='source ~/.bashrc'

# Aliases for common use cases of ls
alias ls="ls --color=auto"
alias l="ls -alF"
alias ll="ls -l"
# And one because I always mistype it
alias sl="ls"

alias cl="clear"

# Show better grep results
alias grep="grep --color=auto"

# Open quickly ypur favorite editor
alias e="nvim"

# Open your neovim config
alias evc="nvim ~/.config/nvim/init.vim"

# Update the neovim config
alias uvc="nvim +PlugUpgrade +PlugUpdate"

# Open your bash config
alias ebc="nvim ~/.bashrc"

# Open your current bash profile
alias ebp="nvim ~/.bash/profiles/$(hostname)"

# Quick xdg-open
alias o="xdg-open"

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
