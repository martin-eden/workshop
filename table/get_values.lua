-- Return list with table values

--[[
  Author: Martin Eden
  Last mod.: 2026-11-12
]]

local add_to_list = request('!.concepts.list.add_item')

return
  function(table)
    assert_table(table)
    local values = { }
    for _, value in pairs(table) do
      add_to_list(values, value)
    end
    return values
  end

--[[
  2015 #
  2026 #
]]
