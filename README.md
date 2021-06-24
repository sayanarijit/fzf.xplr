[![xplr-fzf.gif](https://s4.gifyu.com/images/xplr-fzf.gif)](https://gifyu.com/image/rG21)

Requirements
------------

- [fzf](https://github.com/junegunn/fzf)


Installation
------------

### Install manually

- Add the following line in `~/.config/xplr/init.lua`

  ```lua
  package.path = os.getenv("HOME") .. '/.config/xplr/plugins/?/src/init.lua'
  ```

- Clone the plugin

  ```bash
  mkdir -p ~/.config/xplr/plugins

  git clone https://github.com/sayanarijit/dua-cli.xplr ~/.config/xplr/plugins/dua-cli
  ```

- Require the module in `~/.config/xplr/init.lua`

  ```lua
  require("fzf").setup()
  
  -- Or
  
  require("fzf").setup{
    mode = "default",
    key = "F",
    args = "--preview 'pistol {}'"
  }

  -- Type `F` to spawn fzf in $PWD
  ```


Features
--------

- Supports multi-select paths.
- Search is done on the filtered sorted paths via xplr.
