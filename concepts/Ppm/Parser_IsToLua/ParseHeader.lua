-- Parse header from list to table

-- Last mod.: 2024-11-04

-- Imports:
local PpmFormat = request('^.Constants.Interface')
local IsNormalNumber = request('!.number.is_natural')

--[[
  Input is a list of three strings. Output is table.

  Example:
    { '1920', '1080', '255' } -> { Width = 1920, Height = 1080 }
]]
local ParseHeader =
  function(self, HeaderIs)
    local Width = HeaderIs[1]
    local Height = HeaderIs[2]
    local MaxColorValue = HeaderIs[3]

    Width = tonumber(Width)

    if not IsNormalNumber(Width) then
      return
    end

    Height = tonumber(Height)

    if not IsNormalNumber(Height) then
      return
    end

    MaxColorValue = tonumber(MaxColorValue)

    if not IsNormalNumber(MaxColorValue) then
      return
    end

    if (MaxColorValue ~= self.Constants.MaxColorValue) then
      return
    end

    return
      {
        Width = Width,
        Height = Height,
      }
  end

-- Exports:
return ParseHeader

--[[
  2024-11-03
]]
