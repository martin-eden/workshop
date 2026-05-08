-- Return list with table keys

--[[
  Author: Martin Eden
  Last mod.: 2026-05-08
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')

local get_keys =
  function(Table)
    assert_table(Table)

    local Keys = { }

    for key in pairs(Table) do
      add_to_list(Keys, key)
    end

    return Keys
  end

-- Export:
return get_keys

--[[
  2016
  2026-05-08
]]
