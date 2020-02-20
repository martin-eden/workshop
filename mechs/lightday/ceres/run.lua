--[[
  Lightday length function.

  This algorithm is called "CERES-Wheat model".

  Limitations:

    * <sun_pos_addon_deg> fixed to 6.
      (Daylength include civil twilight.)
    * Earth orbit considered circular.

  Complexity:

    sin  3 cos  2 tan  -
    asin - acos 1 atan -

  Reference:

    journal "Ecological Modelling"
      issue 80, year 1995
      paper "A model comparision for daylength as function of latitude
        and day of the year"
]]

local sin, cos, acos = math.sin, math.cos, math.acos
local rad = math.rad
local max = math.max

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
