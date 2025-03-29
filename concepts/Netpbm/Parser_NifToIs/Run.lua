-- Read in .ppm format. Return structure in itness format (grouped strings)

-- Last mod.: 2025-03-28

--[[
  Normally it returns Lua list with strings and lists.

  On fail it returns nil.

  Fail conditions:

    * Not enough data

  .ppm format allows line comments "# blah blah\n". They are lost.

  Example

    .ppm

      > P3 1 2 255 0 128 255 128 255 0

    is loaded as

      {
        { '1', '2', '255' },
        {
          { { '0', '128', '255' } },
          { { '128', '255', '0' } },
        }
      }
]]

-- Imports:
local IsValidLabel = request('^.Constants.Interface').IsValidLabel

local Init =
  function(self)
    self.ItemGetter.Input = self.Input
    ItemGetter:Init()
  end

--[[
  Convert from pixmap to itness

  Returns nil if problems.
]]
local Parse =
  function(self)
    local Label = self:GetNextItem()

    if not IsValidLabel(Label) then
      return
    end

    local NumItemsInHeader = 3
    local HeaderIs = self:GetChunk(NumItemsInHeader)

    if not HeaderIs then
      return
    end

    local Header = self:ParseHeader(HeaderIs)

    if not Header then
      return
    end

    local PixelsIs = self:GetPixels(Header)

    if not PixelsIs then
      return
    end

    return { HeaderIs, PixelsIs }
  end

-- Exports:
return
  function(self)
    Init(self)

    return Parse(self)
  end

--[[
  2024-11-02
  2024-11-03
  2024-11-05
  2025-03-28
]]
