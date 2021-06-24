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
        LAST_PATH=""
        SELECTED=$(cat "${XPLR_PIPE_DIRECTORY_NODES_OUT:?}" | awk -F / '{print $NF}' | fzf -m --no-sort ]===] .. args.args .. [===[)
        if [ "$SELECTED" ]; then
          while read -r line; do
            CURR_PATH="${PWD:?}/${line:?}"
            echo FocusPath: '"'${CURR_PATH:?}'"' >> "${XPLR_PIPE_MSG_IN:?}"
            [ "$LAST_PATH" ] \
              && echo SelectPath: '"'${CURR_PATH:?}'"' >> "${XPLR_PIPE_MSG_IN:?}" \
              && echo SelectPath: '"'${LAST_PATH:?}'"' >> "${XPLR_PIPE_MSG_IN:?}"
            LAST_PATH="${CURR_PATH:?}"
          done <<< "$SELECTED"
        fi
        ]===]
      },
      "PopMode",
      "ClearScreen",
    },
  }
end

return { setup = setup }
