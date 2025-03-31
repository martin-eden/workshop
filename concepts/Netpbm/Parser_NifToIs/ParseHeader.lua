-- Parse header from list to table

-- Last mod.: 2024-11-25

-- Imports:
local IsNaturalNumber = request('!.number.is_natural')

--[[
  Parse header in Itness format to Lua table

  Example:

    { '60', '30', '255' } -> { Width = 60, Height = 30 }
]]
local ParseHeader =
  function(self, HeaderIs)
    local WidthIs = HeaderIs[1]
    local HeightIs = HeaderIs[2]

    local Width = tonumber(WidthIs)
    assert(IsNaturalNumber(Width))

    local Height = tonumber(HeightIs)
    assert(IsNaturalNumber(Height))

    return { Width = Width, Height = Height }
  end

-- Exports:
return ParseHeader

--[[
  2024-11-03
  2024-11-25
]]
