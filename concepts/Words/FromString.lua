-- Load words from string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-15
]]

--[[
  Set internal data to list of words from given string
]]
local FromString =
  function(self, str)
    local words = self.Words

    -- "%S+" - capture non-space sequences
    for word in str:gmatch('%S+') do
      table.insert(words, word)
    end
  end

-- Export:
return FromString

--[[
  2026-04-15
]]
