-- Return list with table values

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
]]

local add_to_list = request('!.concepts.list.add_item')

-- Export:
return
  function(List)
    assert_table(List)

    local Values = { }

    for _, value in pairs(List) do
      add_to_list(Values, value)
    end

    return Values
  end

--[[
  2015 #
  2026 #
]]
