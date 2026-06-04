-- Convert [Image]'s color to our serialization format

--[[
  Author: Martin Eden
  Last mod.: 2026-06-04
]]

-- Imports:
local denormalize_color = request('!.concepts.Image.Color.Denormalize')
local number_in_range = request('!.number.in_range')

local convert_color =
  function(Color, max_channel_value)
    denormalize_color(Color)

    for _, color_component in ipairs(Color) do
      assert(number_in_range(color_component, 0, max_channel_value))
    end
  end

-- Export:
return convert_color

--[[
  2026-06-04
]]
