-- Add another list to our list

--[[
  Author: Martin Eden
  Last mod.: 2026-05-02
]]

-- Imports:

local add_list =
  function(OurList, AnotherList)
    table.move(AnotherList, 1, #AnotherList, #OurList + 1, OurList)
  end

-- Export:
return add_list

--[[
  2026-05-02
]]
