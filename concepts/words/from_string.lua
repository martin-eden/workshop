-- Return list of words from string

--[[
  Author: Martin Eden
  Last mod.: 2026-09-14
]]

local str_gmatch = string.gmatch
local add_to_list = request('!.concepts.list.add_item')

-- Export:
return
  function(str)
    local Words = { }

    -- "%S+" - capture non-space sequences
    for word in str_gmatch(str, '%S+') do
      add_to_list(Words, word)
    end

    return Words
  end

--[[
  2026 # #
]]
