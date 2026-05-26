-- Return list with table values

--[[
  Author: Martin Eden
  Last mod.: 2026-05-26
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')

local get_values =
  function(List)
    assert_table(List)

    local Values = { }

    for _, value in pairs(List) do
      add_to_list(Values, value)
    end

    return Values
  end

-- Export:
return get_values

--[[
  2015-07
  2026-05-26
]]
