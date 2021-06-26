local function setup(args)

  local xplr = xplr

  if args == nil then
    args = {}
  end

  if args.mode == nil then
    args.mode = "default"
  end

  if args.key == nil then
    args.key = "F"
  end

  if args.args == nil then
    args.args = ""
  end


  xplr.config.modes.builtin[args.mode].key_bindings.on_key[args.key] = {
    help = "fzf search",
    messages = {
      {
        BashExec = [===[
        SELECTED=$(cat "${XPLR_PIPE_DIRECTORY_NODES_OUT:?}" | awk -F / '{print $NF}' | fzf --no-sort ]===] .. args.args .. [===[)
        if [ "$SELECTED" ]; then
          echo FocusPath: '"'$PWD/$SELECTED'"' >> "${XPLR_PIPE_MSG_IN:?}"
        fi

        if [ -d "$SELECTED" ]; then
          echo Enter >> "${XPLR_PIPE_MSG_IN:?}"
        fi
        ]===]
      },
      "PopMode",
    },
  }
end

return { setup = setup }
