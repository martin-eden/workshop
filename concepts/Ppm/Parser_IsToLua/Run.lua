-- Gets structure as grouped strings. Returns table with nice names

--[[
  Custom Lua format

  Input

    {
      { '1', '2', '255' },
      {
        { { '0', '128', '255' } },
        { { '128', '255', '0' } },
      }
    }

  is converted to

    {
      Width = 1,
      Height = 2,
      Pixels =
        {
          { { Red = 0, Green = 128, Blue = 255 } },
          { { Red = 128, Green = 255, Blue = 0 } },
        }
    }

  On fail it returns nil.

  Some fail conditions:

    * Holes at Input[2] data matrix.
    * If there is color component value that is not in range [0, 255]
    * Input[1][3] is not "255". It is max color value.

      Format allows integers between 1 and 65536.

      Here we're breaking standard by overnarrowing accepted
      values. Let it be so.
]]

-- Last mod.: 2024-11-06

-- Exports:
return
  function(self, DataIs)
    local HeaderIs = DataIs[1]

    local Header = self:ParseHeader(HeaderIs)

    if not Header then
      return
    end

    local PixelsIs = DataIs[2]

    local Pixels = self:ParsePixels(PixelsIs, Header)

    if not Pixels then
      return
    end

    return
      {
        Width = Header.Width,
        Height = Header.Height,
        Pixels = Pixels,
      }
  end

--[[
  2024-11-02
  2024-11-03
]]
