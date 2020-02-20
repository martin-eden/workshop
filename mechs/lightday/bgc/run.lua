--[[
  Lightday length function.

  This algorithm is called "Forest-BGC model".

  Limitations:

    * <sun_pos_addon_deg> fixed to 0.
      (Sunrise/sunset is when center of sun is even with horizon.)
    * Earth orbit considered circular (not sure).
    * Works only for non-negative latitudes.

  Complexity:

    sin  1 cos  - tan  -
    asin - acos - atan -

  Reference:

    journal "Ecological Modelling"
      issue 80, year 1995
      paper "A model comparision for daylength as function of latitude
        and day of the year"
]]

local sin = math.sin
local exp = math.exp

return
  function(self)
    self.sun_pos_addon_deg = 0.0

    assert(self.latitude_deg >= 0)

    local amplitude = exp(7.42 + 0.045 * self.latitude_deg) / 3600

    local day_length =
      amplitude * sin((self.day_number - 79) * 0.01721) + 12

    return day_length
  end
