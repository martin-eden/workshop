--[[
  Lightday length function.

  This algorithm is called "CBM model".

  Earth orbit considered elliptical.

  <sun_pos_addon_deg> adjustable.

  Reference description:
    Journal "Ecological Modelling"
      issue 80, year 1995, pp. 87-95
      paper "A model comparision for daylength as function of latitude
        and day of the year"
]]

local sin, asin, cos, acos, tan, atan =
  math.sin, math.asin, math.cos, math.acos, math.tan, math.atan
local rad, pi = math.rad, math.pi

local get_daylength =
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

return
  new(
    request('interface'),
    {
      name = 'CBM model',
      get_daylength = get_daylength,
    }
  )
