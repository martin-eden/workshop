-- Download file by URL

--[[
  Author: Martin Eden
  Last mod.: 2026-08-12
]]

-- Imports:
local get_cmd_download_file = request('!.mechs.cmdline.get_cmd_download_file')

local download_file =
  function(url, pathname)
    local Command = get_cmd_download_file(url, pathname)

    local is_ok, ExecResult = Command:Execute()

    if not is_ok then
      return
        false,
        {
          command = Command:ToString(),
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
