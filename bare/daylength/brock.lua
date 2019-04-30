--[[
  Lightday length function.

  This algorithm is called "Brock model".

  Sunrise/sunset is when center of sun is even with horizon
  (<sun_pos_addon_deg> = 0).

  Earth orbit considered circular.

  Reference description:
    Journal "Ecological Modelling"
      issue 80, year 1995, pp. 87-95
      paper "A model comparision for daylength as function of latitude
        and day of the year"
]]

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

local get_daylength =
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

return
  new(
    request('interface'),
    {
      name = 'Brock model',
      get_daylength = get_daylength,
    }
  )
