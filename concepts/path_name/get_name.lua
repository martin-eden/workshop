-- Return leaf name of pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local is_directory = request('is_directory')
local self_dir = request('syntels').self_dir

return
  function(pathname)
    local leaf_name

    if is_directory(pathname) then
      leaf_name = pathname[#pathname - 1]
    else
      leaf_name = pathname[#pathname]
    end

    if (leaf_name == '') then
      leaf_name = self_dir
    end

    return leaf_name
  end

--[[
  2026 #
]]
