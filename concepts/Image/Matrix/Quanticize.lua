-- Granulate pixels values

-- Last mod.: 2025-04-22

-- Imports:
local Granulate = request('!.number.float.granulate')

local Quanticize =
  function(Image, NumColorChannelLevels)
    assert_table(Image)
    assert_integer(NumColorChannelLevels)

    for Line = 1, Image.Height do
      for Column = 1, Image.Width do
        for Channel = 1, #Image[Line][Column] do
          Image[Line][Column][Channel] =
            Granulate(Image[Line][Column][Channel], NumColorChannelLevels)
        end
      end
    end
  end

-- Exports:
return Quanticize

--[[
  2025-04-22
]]
