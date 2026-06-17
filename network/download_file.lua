-- Download file by URL

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

-- Imports:
local get_cmd_download_file = request('!.mechs.cmdline.get_cmd_download_file')
local run_cmd = request('!.concepts.shell.execute')

local download_file =
  function(url, pathname)
    local cmd = get_cmd_download_file(url, pathname)

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
return download_file

--[[
  2026-06-17
  2026-06-18
]]
