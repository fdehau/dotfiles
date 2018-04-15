# Dotfiles

![](./media/screenshot.png)

This repository holds my personal dotfiles. They contain the configuration of
most programs I use on a day to day basis while at work or at home. I spend
most of my time between terminals and a browser thus I look for an environment
that is simple to use and to maintain. Someone with an interest in unix
customization will find a pretty common setup but since I've been asked time to
time what was actually running on my screen I thought I could put them in the
open.

## Components

- [i3](https://i3wm.org/): The classic tiling window manager. Used in
combination with [i3lock](https://github.com/i3/i3lock) and
[i3blocks](https://github.com/vivien/i3blocks).
- [st](https://st.suckless.org/): Because why not ?
- bash: Nothing fancy here.
- [neovim](https://github.com/neovim/neovim): Not a Vim expert but I've grown
to love its versatility and capabilities. I'm a long term user of the fork and
its ecosystem.
- [tmux](https://github.com/tmux/tmux): A common tool for terminal centric
work-flows.
- [rofi](https://github.com/DaveDavenport/rofi): Used as an application
launcher.
- [dunst](https://github.com/dunst-project/dunst): For the good old desktop
notifications.

## Structure

The dotfiles are managed by a main [Makefile](./Makefile). Components can be
installed using `make install`. Other commands can be found by running `make
help`.

Configuration for each component is located under the `config` directory.
Beware though, some are templates and the resulting configuration files need to
be generated using [tmpl](https://github.com/fdehau/tmpl).

Moreover, this repository is only the public side of my dotfiles. I wanted the
same setup at home and at work but since the machines I use are sightly
different I needed to make local adjustments. Therefore these dotfiles need
three additional files to work:

- A set of variables (json) used to generate the configuration files. This for
  example includes the size of the font for `i3` or the email to use with git.
- A local bash profile (bash) loaded after the common one.
- A colorscheme (json) to use across all applications that support it. 

I store those files in a separate repository.

The [Makefile](./Makefile) will look for the paths of those files in
`~/.config/dotfiles/config.mk`. The content of the file should define:
`DOTFILES_CONFIG`, `DOTFILES_COLORSCHEME` and `DOTFILES_BASH_PROFILE`. For example, it
could look like:

```Makefile
DOTFILES_COLORSCHEME = $(HOME)/profiles/colors/gruvbox.json
DOTFILES_CONFIG = $(HOME)/profiles/config/home.json
DOTFILES_BASH_PROFILE = $(HOME)/profiles/bash/home.sh
```
The variables that need to be defined are:

```json
{
    "git": {
        "email": "me@example.com",
        "name": "Firstname Lastname"
    },
    "i3": {
        "terminal": "st",
        "font": {
            "family": "Iosevka",
            "size": 12
        }
    },
    "i3bar": {
        "font": {
            "family": "Iosevka",
            "family2": "FontAwesome5Free",
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
    }
}
```

On the other hand the colorscheme should have the following properties
([gruvbox](https://github.com/morhetz/gruvbox) in my case):

```json
{
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
    },
    "hex_colors": {
        "black": "0x282828",
        "red": "0xCC241D",
        "green": "0x98971A",
        "yellow": "0xD79921",
        "blue": "0x458588",
        "magenta": "0xB16286",
        "cyan": "0x689D6A",
        "gray": "0xA89984",
        "dark_gray": "0x928374",
        "bright_red": "0xFB4934",
        "bright_green": "0xB8BB26",
        "bright_yellow": "0xFABD2F",
        "bright_blue": "0x83A598",
        "bright_magenta": "0xD3869B",
        "bright_cyan": "0x8EC07C",
        "white": "0xEBDBB2"
    }
}
```
