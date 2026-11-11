-- Download file by URL

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local get_cmd_download_file =
  request('!.mechs.cmdline.get_cmd_download_file')

return
  function(url, pathname)
    local command = get_cmd_download_file(url, pathname)

    local is_ok, exec_result = command:execute()

    if not is_ok then
      return
        false,
        {
          command = command:ToString(),
          result = exec_result,
        }
    end

    return true
  end

--[[
  2026 # #
]]
