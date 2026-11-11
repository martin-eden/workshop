-- Clone git repository to given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local get_cmd_clone_repo = request('!.mechs.cmdline.get_cmd_clone_repo')

return
  function(url, dest_dir)
    local command = get_cmd_clone_repo(url, dest_dir)

    local is_ok, exec_result = command:execute()

    if not is_ok then
      return
        false,
        {
          command = command:to_string(),
          result = exec_result,
        }
    end

    return true
  end

--[[
  2026 #
]]
