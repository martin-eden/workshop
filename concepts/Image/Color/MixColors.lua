-- Mix two colors in given proportion

-- Last mod.: 2025-04-23

-- Imports:
local MixNumbers = request('!.number.mix_numbers')

local MixColors =
  function(ColorA, ColorB, ColorAPortion)
    local Result = {}

    for ComponentIndex = 1, #ColorA do
      Result[ComponentIndex] =
        MixNumbers(
          ColorA[ComponentIndex],
          ColorB[ComponentIndex],
          ColorAPortion
        )
    end

    return Result
  end

-- Exports:
return MixColors

--[[
  2025-04-23
]]
