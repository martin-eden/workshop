-- Return list of words from string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-14
]]

local str_gmatch = string.gmatch
local add_to_list = request('!.concepts.list.add_item')

return
  function(str)
    local words = { }
    -- "%S+" - capture non-space sequences
    for word in str_gmatch(str, '%S+') do
      add_to_list(words, word)
    end
    return words
  end

--[[
  2026 # #
]]
