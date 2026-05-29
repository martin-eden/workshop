-- Return list of words from string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')

local from_string =
  function(str)
    local Words = { }

    -- "%S+" - capture non-space sequences
    for word in str:gmatch('%S+') do
      add_to_list(Words, word)
    end

    return Words
  end

-- Export:
return from_string

--[[
  2026-04-15
  2026-05-29
]]
