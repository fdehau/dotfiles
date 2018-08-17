#!/bin/bash

# Send alert
# Usage: sleep 5; alert
function alert {
  local status=$?
  local message="$1"
  if [[ "$message" == "" ]]; then
    message="command"
  fi
  if [[ $status -eq 0 ]]; then
    message+=' finished'
    local urgency='low'
  else
    message+=' failed'
    local urgency='normal'
  fi
  notify-send \
    --urgency=$urgency \
    -a 'Bash' \
    "$message"
}

function fz {
  cd $(z -l $@ | fzf-tmux --tac | awk '{ print $2 }')
}

function zf {
  cd $(z -tl $@ | fzf-tmux --tac | awk '{ print $2 }')
}

function fcd {
  cd $(fd --type d . | fzf-tmux --tac)
}

function use_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

function use_rbenv() {
  eval "$(rbenv init -)"
}

function show_colors {
  awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
      r = 255-(colnum*255/76);
      g = (colnum*510/76);
      b = (colnum*255/76);
      if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
      }
      printf "\n";
  }'
}
