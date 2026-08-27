-- Return list with table keys

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
]]

local add_to_list = request('!.concepts.list.add_item')

-- Export:
return
  function(List)
    assert_table(List)

    local Keys = { }

    for key in pairs(List) do
      add_to_list(Keys, key)
    end

    return Keys
  end

--[[
  2016
  2026-05-08
]]
