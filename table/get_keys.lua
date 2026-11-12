-- Return list with table keys

--[[
  Author: Martin Eden
  Last mod.: 2026-11-12
]]

local add_to_list = request('!.concepts.list.add_item')

return
  function(table)
    assert_table(table)
    local keys = { }
    for key in pairs(table) do
      add_to_list(keys, key)
    end
    return keys
  end

--[[
  2016
  2026-05-08
]]
