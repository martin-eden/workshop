--[[
  Constrain number element to be within specified range.
]]

local constrain = request('!.number.constrain')
local path_set_value = request('!.table.path_set_value')

return
  function(data, path, value, min, max)
    path_set_value(data, path, constrain(value, min, max))
  end
