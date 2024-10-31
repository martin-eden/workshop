-- Implode list of lines to string

-- Last mod.: 2024-10-31

-- Imports:
local LinesToString = request('!.string.from_lines')

-- Exports:
return
  function(self)
    return LinesToString(self.Lines)
  end

--[[
  2024-10-31
]]
