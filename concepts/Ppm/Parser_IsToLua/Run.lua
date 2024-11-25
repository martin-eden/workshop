-- Gets structure as grouped strings. Returns table with nice names

-- Last mod.: 2024-11-25

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
      -- aka .Lines
      {
        {
          -- aka .Colors
          { 0, 128, 255 },
          -- aka .Length
          1
        },
        { { 128, 255, 0 }, 1 },
      }
      -- aka .NumLines
      2,
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

    return Pixels
  end

--[[
  2024-11-02
  2024-11-03
  2024-11-25
]]
