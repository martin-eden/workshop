-- [Internal] Return cleaned-up files list

--[[
  Author: Martin Eden
  Last mod.: 2026-09-23
]]

local remove_prefix = request('!.string.remove_prefix')
local add_to_list = request('!.concepts.list.add_item')
local sort = table.sort

return
  function(PathNames, base_dir)
    local Result = { }

    for idx, file_name in ipairs(PathNames) do
      local cleaned_file_name = remove_prefix(file_name, base_dir)
      if (cleaned_file_name ~= '') then
        add_to_list(Result, cleaned_file_name)
      end
    end

    sort(Result)

    return Result
  end

--[[
  2026-09-23
]]
