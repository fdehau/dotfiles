function fcd -d "go to a subdirectory using fzf"
  set -l choice "$(fd -t d | fzf-tmux --tac | string trim)"
  if test -n "$choice"
    cd $choice
  end
end
