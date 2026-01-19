-- Read in .ppm format. Return structure in itness format (grouped strings)

--[[
  Author: Martin Eden
  Last mod.: 2026-01-15
]]

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
        'P3',
        { '1', '2', '255' },
        {
          { { '0', '128', '255' } },
          { { '128', '255', '0' } },
        }
      }
]]

local Init =
  function(self)
    self.ItemGetter.Input = self.Input
    self.ItemGetter:Init()
  end

--[[
  Convert from pixmap to itness

  Returns nil if problems.
]]
local Parse =
  function(self)
    local LabelIs = self.ItemGetter:GetNextItem()

    if not self.Settings:SetFormatLabel(LabelIs) then
      return
    end

    local NumItemsInHeader = 3
    local HeaderIs = self.ItemGetter:GetChunk(NumItemsInHeader)

    if not HeaderIs then
      return
    end

    local ImageSettings = self:ParseHeader(HeaderIs)

    if not ImageSettings then
      return
    end

    local NumColorComponents
    do
      local ColorFormat = self.Settings.ColorFormat
      if
        (ColorFormat == 'bw') or
        (ColorFormat == 'gs')
      then
        NumColorComponents = 1
      elseif (ColorFormat == 'rgb') then
        NumColorComponents = 3
      end
      assert(NumColorComponents)
    end
    ImageSettings.NumColorComponents = NumColorComponents

    local PixelsIs = self:GetPixels(ImageSettings)

    if not PixelsIs then
      return
    end

    return { LabelIs, HeaderIs, PixelsIs }
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
  2025-03-31
]]
