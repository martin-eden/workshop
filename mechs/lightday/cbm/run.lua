--[[
  Lightday length function.

  This algorithm is called "CBM model".

  Advantages:

    * Earth orbit considered elliptical.
    * <sun_pos_addon_deg> adjustable.

  Complexity:

    sin  3 cos  3 tan  1
    asin 1 acos 1 atan 1

  Reference:

    journal "Ecological Modelling"
      issue 80, year 1995
      paper "A model comparision for daylength as function of latitude
        and day of the year"
]]

local sin, asin, cos, acos, tan, atan =
  math.sin, math.asin, math.cos, math.acos, math.tan, math.atan
local rad, pi = math.rad, math.pi

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
