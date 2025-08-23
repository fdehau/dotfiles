# Dotfiles

This repository holds my personal dotfiles. These days I'm running a Mac with
a very minimal config (Ghostty+Neovim) but the remains of my old Linux setup
(st+tmux+i3) are still there.

## Structure

The dotfiles are managed by a main [Makefile](./Makefile). Components can be
installed using `make install`. Other commands can be found by running `make
help`.

Configuration for each component is located under the `config` directory.
Beware though, some files are templates and the resulting configuration files
need to be generated using [tmpl](https://github.com/fdehau/tmpl). The
variables used in those templates are defined in
`~/.config/dotfiles/config.json`. The variables that need to be defined are:

```json
{
  "name": "home",
  "git": {
    "email": "me@example.com",
    "name": "Firstname Lastname"
  },
  "i3": {
    "terminal": "st",
    "font": {
      "family": "Iosevka",
      "size": 12
    },
    "bar_font": {
      "family": "Iosevka",
      "size": 10
    },
    "icon_font": {
      "family": "FontAwesome5Free",
      "size": 10
    }
  },
  "st": {
    "font": {
      "family": "Iosevka Term",
      "size": 28
    }
  },
  "dunst": {
    "font": {
      "family": "Iosevka Term",
      "size": 12
    }
  },
  "rofi": {
    "font": {
      "family": "Iosevka Term",
      "size": 30
    }
  },
  "tmux": {
    "terminal": "st-256color",
    "shell": "/bin/bash",
  },
  "colors": {
    "black": "#282828",
    "red": "#CC241D",
    "green": "#98971A",
    "yellow": "#D79921",
    "blue": "#458588",
    "magenta": "#B16286",
    "cyan": "#689D6A",
    "gray": "#A89984",
    "dark_gray": "#928374",
    "bright_red": "#FB4934",
    "bright_green": "#B8BB26",
    "bright_yellow": "#FABD2F",
    "bright_blue": "#83A598",
    "bright_magenta": "#D3869B",
    "bright_cyan": "#8EC07C",
    "white": "#EBDBB2"
  }
}
```
