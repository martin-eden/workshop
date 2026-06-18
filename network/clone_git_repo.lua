-- Clone git repository to given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

-- Imports:
local get_cmd_clone_repo = request('!.mechs.cmdline.get_cmd_clone_repo')
local run_cmd = request('!.concepts.shell.execute')

local clone_git_repo =
  function(url, dest_dir)
    local cmd = get_cmd_clone_repo(url, dest_dir)

    local is_ok, ExecResult = run_cmd(cmd)

    if not is_ok then
      return
        false,
        {
          command = cmd,
          Result = ExecResult,
        }
    end

    return true
  end

-- Export:
return clone_git_repo

--[[
  2026-06-18
]]
