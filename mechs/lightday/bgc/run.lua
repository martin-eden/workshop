-- Lightday calculation: Forest-BGC model

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

--[[
  Cost:

    2 ( sin exp )

  Properties:

    ☐ <sun_pos_addon_deg> adjustable

      Fixed to 0. Sunrise/sunset is when center of sun is even with horizon

    ☐ Earth orbit considered elliptical

      Considered circular

    * Works only for non-negative latitudes
--]]

local sin = math.sin
local exp = math.exp

-- Export:
return
  function(self)
    self.sun_pos_addon_deg = 0.0

    assert(self.latitude_deg >= 0, 'Works only for non-negative latitudes.')

    local amplitude = exp(7.42 + 0.045 * self.latitude_deg) / 3600

    local day_length =
      amplitude * sin((self.day_number - 79) * 0.01721) + 12

    return day_length
  end

--[[
  2019
  2026-05-29
]]
