local q = xplr.util.shell_quote

local function fzf(args, paths)
  local cmd = q(args.bin) .. " -m " .. args.args
  if paths ~= nil then
    cmd = cmd .. " <<< " .. q(paths)
  end

  local p = io.popen(cmd, "r")
  local output = p:read("*a")
  p:close()

  local lines = {}
  for line in output:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end

  local count = #lines

  if count == 0 then
    return
  elseif count == 1 then
    local path = lines[1]
    local msgs = {
      { FocusPath = path },
    }

    if args.enter_dir then
      local isdir = xplr.util.shell_execute("test", { "-d", path }).returncode == 0
      if isdir then
        table.insert(msgs, "Enter")
      end
    end

    return msgs
  else
    local msgs = {}
    for i, line in ipairs(lines) do
      table.insert(msgs, { SelectPath = line })
      if i == count then
        table.insert(msgs, { FocusPath = line })
      end
    end
    return msgs
  end
end

local function setup(args)
  local xplr = xplr

  args = args or {}
  args.mode = args.mode or "default"
  args.key = args.key or "ctrl-f"
  args.bin = args.bin or "fzf"
  args.args = args.args or ""

  if args.recursive == nil then
    args.recursive = false
  end

  if args.enter_dir == nil then
    args.enter_dir = false
  end

  xplr.config.modes.builtin[args.mode].key_bindings.on_key[args.key] = {
    help = "fzf search",
    messages = {
      "PopMode",
      { CallLua = "custom.fzf.search" },
    },
  }

  xplr.fn.custom.fzf = {}
  xplr.fn.custom.fzf.search = function(app)
    if args.recursive then
      return fzf(args)
    else
      local paths = {}
      for _, n in ipairs(app.directory_buffer.nodes) do
        table.insert(paths, n.relative_path)
      end
      return fzf(args, table.concat(paths, "\n"))
    end
  end
end

return { setup = setup }
