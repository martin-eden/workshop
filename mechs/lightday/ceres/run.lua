-- Lightday calculation: CERES-Wheat model

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

--[[
  Cost:

    6 ( sin * 3 cos * 2 acos * 1 )

  Limitations:

    ☐ <sun_pos_addon_deg> adjustable

      Fixed to 6. Daylength includes civil twilight.

    ☐ Earth orbit considered elliptical

      Considered circular
]]

local sin, cos, acos = math.sin, math.cos, math.acos
local rad = math.rad
local max = math.max

-- Export:
return
  function(self)
    self.sun_pos_addon_deg = 6.0

    local latitude = rad(self.latitude_deg)

    local sun_declination =
      0.4093 * sin(0.0172 * (self.day_number - 82.2))

    local day_length =
      7.639 *
      acos(
        max(
          -1,
          (-0.1047 -
            sin(latitude) * sin(sun_declination)
          ) /
          (cos(latitude) * cos(sun_declination))
        )
      )

    return day_length
  end

--[[
  2019
  2026-05-29
]]
