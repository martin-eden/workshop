-- Gets structure as grouped strings. Returns table with nice names

-- Last mod.: 2024-11-25

--[[
  Custom Lua format

  Input

    1x2 bitmap

    {
      { '1', '2', '255' },
      {
        { { '0', '128', '255' } },
        { { '128', '255', '0' } },
      }
    }

  is converted to

    {
      { { 0, 128, 255 } },
      { { 128, 255, 0 } },
    }

  On fail it returns nil.

  Some fail conditions:

    * Holes at Input[2] data matrix.
    * If there is color component value that is not in range [0, 255]
]]

-- Exports:
return
  function(self, DataIs)
    local PixelsIs = DataIs[2]

    local Pixels = self:ParsePixels(PixelsIs)

    if not Pixels then
      return
    end

    return Pixels
  end

--[[
  2024-11-02
  2024-11-03
  2024-11-25
]]
