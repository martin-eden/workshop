-- Lightday calculation: CBM model

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

--[[
  Cost:

    10 ( sin * 3 cos * 3 asin * 1 acos * 1 tan * 1 atan * 1)

  Properties:

    ☑ <sun_pos_addon_deg> adjustable
    ☑ Earth orbit considered elliptical
]]

local sin, asin, cos, acos, tan, atan =
  math.sin, math.asin, math.cos, math.acos, math.tan, math.atan
local rad, pi = math.rad, math.pi

-- Export:
return
  function(self)
    local sun_pos_addon_angle = rad(self.sun_pos_addon_deg)
    local latitude = rad(self.latitude_deg)
    local revolution_angle =
      0.2163108 + 2 * atan(0.9671396 * tan(0.0086 * (self.day_number - 186)))
    local sun_declination = asin(0.39795 * cos(revolution_angle))
    local day_length =
      24 -
      24 / pi * acos(
        (
          sin(sun_pos_addon_angle) +
          sin(latitude) * sin(sun_declination)
        ) /
        (cos(latitude) * cos(sun_declination))
      )
    return day_length
  end

--[[
  2019
  2026-05-29
]]
