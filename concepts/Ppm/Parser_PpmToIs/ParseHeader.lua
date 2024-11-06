-- Parse header from list to table

-- Last mod.: 2024-11-03

-- Imports:
-- Higher-level parser. We need it to parse header chunk
local HigherParser = request('^.Parser_IsToLua.Interface')

--[[
  Semantics is out of scope of this class. We're grouping lexer.

  However.. However to group pixels data we need to know
  how much pixels there are. We have header chunk. But we don't
  know values in it. But higher-level parser can parse it for us.
]]

--[[
  Calling higher-level code pisses me. Alternative is to
  split higher-level parser by separating header parsing.
  But it uglyfies design in some other way.
]]

-- Exports:
return
  function(self, HeaderIs)
    return HigherParser:ParseHeader(HeaderIs)
  end

--[[
  2024-11-03
]]
