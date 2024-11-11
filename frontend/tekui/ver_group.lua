-- Return vertical group object

-- Last mod.: 2024-11-11

local group = request('group')
local force_merge = request('!.table.merge_and_patch')

return
  function(...)
    local result = group(...)
    force_merge(
      result,
      {
        Orientation = 'vertical',
      }
    )

    return result
  end

--[[
  2020-02
]]
