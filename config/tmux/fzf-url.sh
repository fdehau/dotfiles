#!/usr/bin/env bash

# Based on https://github.com/wfxr/tmux-fzf-url with few tweaks

fzf_cmd() {
    fzf-tmux -d 35% --multi --exit-0 --bind='ctrl-r:toggle-all' --bind='ctrl-s:toggle-sort'
}

parse_urls() {
  echo "$1" \
    | grep -oE '(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'
}

parse_wwws() {
  echo "$1" \
    | grep -oE 'www\.[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}(/\S+)*' \
    | sed 's/^\(.*\)$/http:\/\/\1/'
}

parse_ips() {
  echo "$1" \
    | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}(:[0-9]{1,5})?(/\S+)*' \
    | sed 's/^\(.*\)$/http:\/\/\1/'
}

merge() {
    for item in "$@" ; do
        echo "$item"
    done
}

# Retrieve content from current pane and extract urls, wwws and ips
content="$(tmux capture-pane -J -p)"
urls=($(parse_urls "$content"))
wwws=($(parse_wwws "$content"))
ips=($(parse_ips "$content"))


# Merge results in a single list, pipe it to fzf and then open the selected
# links in your favorite browser
if  hash xdg-open &>/dev/null; then
    open_cmd='nohup xdg-open'
elif hash open &>/dev/null; then
    open_cmd='open'
fi
merge "${urls[@]}" "${wwws[@]}" "${ips[@]}"|
    sort -u |
    fzf_cmd |
    xargs -n1 -I {} $open_cmd {} &>/dev/null ||
    true

