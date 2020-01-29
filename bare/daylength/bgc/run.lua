--[[
  Lightday length function.

  This algorithm is called "Forest-BGC model".

  Sunrise/sunset is when center of sun is even with horizon
  (<sun_pos_addon_deg> = 0).

  Works only for non-negative latitudes.

  Reference description:
    Journal "Ecological Modelling"
      issue 80, year 1995, pp. 87-95
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
