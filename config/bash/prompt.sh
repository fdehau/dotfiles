DARK_GREY="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
CYAN="\033[0;36m"
LIGHT_GRAY="\033[0;37m"

BOLD_DARK_GREY="\033[1;30m"
BOLD_RED="\033[1;31m"
BOLD_GREEN="\033[1;32m"
BOLD_YELLOW="\033[1;33m"
BOLD_BLUE="\033[1;34m"
BOLD_MAGENTA="\033[1;35m"
BOLD_CYAN="\033[1;36m"
BOLD_LIGHT_GRAY="\033[1;37m"

SHORT_COMMAND_THRESHOLD=5

RESET="\033[0m"

# reset the timer, called just after command invokation
function timer_start {
  timer=${timer:-$SECONDS}
}
trap 'timer_start' DEBUG

# compute the execution time, called just before the prompt is printed
function timer_stop {
  delta=$(($SECONDS - $timer))
  local hours=$(( delta / 60 / 60 ))
  local minutes=$(( delta / 60 % 60))
  local seconds=$(( delta % 60))
  last_timer=""
  # don't show the time for short command
  if [[ $delta -gt $SHORT_COMMAND_THRESHOLD ]]; then
    [[ $hours -gt 0 ]] && last_timer+="${hours}h"
    [[ $minutes -gt 0 ]] && last_timer+="${minutes}m"
    last_timer+="${seconds}s"
  fi
  unset timer
}

# timer stop must be the last command
PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"

function git_status {
  local status="$(git status 2> /dev/null)"

  # Compute a state from the status
  local on_branch="s/^On branch \(.*\)/\1/p"
  local on_commit="s/^HEAD detached at \(.*\)$/\1/p"
  local on_behind="s/^Your branch is behind .* by \([0-9]*\) commit.*/ -\1/p"
  local on_ahead="s/^Your branch is ahead .* by \([0-9]*\) commit.*/ +\1/p"
  local on_diverged="s/and have \([0-9]*\) and \([0-9]*\) different commits each.*/ +\1 -\2/p"
  local on_rebase="s/^You are currently rebasing branch '\(.*\)' on '\(.*\)'\./rebase:\1:\2/p"
  local cmds="$on_branch;$on_commit;$on_diverged;$on_diverged;$on_rebase;$on_ahead;$on_behind;";
  local state=$(echo -n "$status" | sed -n "$cmds" | tr -d "\n")

  # Choose a color to display the state
  local color=$BOLD_LIGHT_GRAY
  if [[ $status =~ "Changes not staged for commit:" ]]; then
    color=$BOLD_RED
  elif [[ $status =~ "Changes to be committed:" ]]; then
    color=$BOLD_YELLOW
  elif [[ $status =~ "nothing to commit" ]]; then
    color=$BOLD_GREEN
  elif [[ $status =~ "Untracked files:" ]]; then
    color=$BOLD_CYAN
  fi

  if [[ "$state" != "" ]]; then
    echo -e " ${color}($state)${RESET}"
  fi
}

function status_color {
  if [[ $LAST_STATUS -eq 0 ]]; then
    echo -e $BOLD_GREEN
  else
    echo -e $BOLD_RED
  fi
}

# Username
PS1="\[$BOLD_CYAN\]\u\[$RESET\]"
# at
PS1+="\[$BOLD_YELLOW\]@\[$RESET\]"
# hostname
PS1+="\[$BOLD_BLUE\]\h\[$RESET\]"
# in
PS1+="\[$BOLD_YELLOW\]:\[$RESET\]"
# current directory
PS1+="\[$BOLD_MAGENTA\]\w\[$RESET\]"
# on branch
PS1+="\$(git_status)"
# with last command time
PS1+=" \${last_timer}"
# do
PS1+="\n\[\$(status_color)\]>>\[$RESET\] "
export PS1
