-- Parse pixmap header

-- Last mod.: 2024-11-03

-- Same notes as for ParseHeader() in [Parse_PpmToIs]

-- Imports:
local HigherParser = request('^.Parser_IsToLua.Interface')

-- Exports:
return
  function(self, HeaderIs)
    return HigherParser:ParseHeader(HeaderIs)
  end

--[[
  2024-11-03
]]
