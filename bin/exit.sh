#!/usr/bin/env bash

case "$1" in
  lock)
    case $2 in
      i3)
        ~/dotfiles/bin/lock.sh i3lock
        ;;
      sway)
        ~/dotfiles/bin/lock.sh swaylock
        ;;
    esac
    ;;
  logout)
    case "$2" in
      i3)
        i3-msg exit
        ;;
      sway)
        swaymsg exit
        ;;
    esac
    ;;
  suspend)
    systemctl suspend
    ;;
  hibernate)
    systemctl hibernate
    ;;
  reboot)
    systemctl reboot
    ;;
  shutdown)
    systemctl poweroff
    ;;
  *)
    echo "Usage: $0 [lock|logout|suspend|hibernate|reboot|shutdown]"
    exit 2
esac

exit 0
