function fz -d "jump to a known directory using fzf"
   set -l choice "$(zoxide query -l | fzf-tmux --tac | string trim)"
   if test -n "$choice"
     cd $choice
   end
end
