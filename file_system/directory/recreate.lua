-- Create new directory

--[[
  Author: Martin Eden
  Last mod.: 2026-09-02
]]

local remove_dir = request('remove')
local create_dir = request('create')

-- Export:
return
  function(dir_name)
    return remove_dir(dir_name) and create_dir(dir_name)
  end

--[[
  2026-09-02
]]
