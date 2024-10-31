-- Explode string to list of lines

-- Last mod.: 2024-10-31

-- Imports:
local StringToLines = request('!.string.to_lines')

-- Exports:
return
  function(self, String)
    self.Lines = StringToLines(String)
  end

--[[
  2024-10-31
]]
