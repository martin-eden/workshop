-- Function to check that our list contains another list

--[[
  Author: Martin Eden
  Last mod.: 2026-04-15
]]

local MapValues = request('!.table.map_values')

--[[
  Check that Outer List is present in Base List

  Does not support nested lists.
]]
local Contains =
  function(BaseList, OuterList)
    local Has = MapValues(BaseList)
    for Index = 1, #OuterList do
      if not Has[OuterList[Index]] then
        return false
      end
    end
    return true
  end

-- Export:
return Contains

--[[
  2026-04-15
]]
