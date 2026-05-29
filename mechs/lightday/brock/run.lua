-- Lightday calculation: Brock model

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

--[[
  Cost:

    4 ( tan * 2 sin * 1 acos * 1 )

  Properties:

    ☐ <sun_pos_addon_deg> adjustable

      Fixed to 0. Sunrise/sunset is when center of sun is even with horizon

    ☐ Earth orbit considered elliptical

      Considered circular
--]]

local sin, acos, tan = math.sin, math.acos, math.tan
local rad, deg = math.rad, math.deg

local sin_deg =
  function(angle_deg)
    return sin(rad(angle_deg))
  end

local acos_deg =
  function(cos_value)
    return deg(acos(cos_value))
  end

local tan_deg =
  function(angle_deg)
    return tan(rad(angle_deg))
  end

-- Export:
return
  function(self)
    self.sun_pos_addon_deg = 0.0

    local sun_declination_deg =
      23.45 * sin_deg(360 * (283 + self.day_number) / 365)

    local hour_angle_deg =
      acos_deg(
        -tan_deg(self.latitude_deg) * tan_deg(sun_declination_deg)
      )

    local day_length = 2 * hour_angle_deg / 15

    return day_length
  end

--[[
  2019
  2026-05-29
]]
