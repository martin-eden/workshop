-- Implode list of lines to string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

-- Import:
local LinesToString = request('!.string.from_lines')

-- Export:
return
  function(self)
    return LinesToString(self.Lines)
  end

--[[
  2024-10-31
]]
