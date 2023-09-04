[![xplr-fzf.gif](https://s4.gifyu.com/images/xplr-fzf.gif)](https://gifyu.com/image/rG21)

## Requirements

- [fzf](https://github.com/junegunn/fzf)

## Installation

### Install manually

- Add the following line in `~/.config/xplr/init.lua`

  ```lua
  local home = os.getenv("HOME")
  package.path = home
  .. "/.config/xplr/plugins/?/init.lua;"
  .. home
  .. "/.config/xplr/plugins/?.lua;"
  .. package.path
  ```

- Clone the plugin

  ```bash
  mkdir -p ~/.config/xplr/plugins

  git clone https://github.com/sayanarijit/fzf.xplr ~/.config/xplr/plugins/fzf
  ```

- Require the module in `~/.config/xplr/init.lua`

  ```lua
  require("fzf").setup()

  -- Or

  require("fzf").setup{
    mode = "default",
    key = "ctrl-f",
    bin = "fzf",
    args = "--preview 'pistol {}'",
    recursive = false,  -- If true, search all files under $PWD
    enter_dir = false,  -- Enter if the result is directory
  }

  -- Press `ctrl-f` to spawn fzf in $PWD
  ```

## Features

- Search is done on the filtered sorted paths via xplr.
- Option to toggle into recursive search.
- Option to toggle enter directory.
