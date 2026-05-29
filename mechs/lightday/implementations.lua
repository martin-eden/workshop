-- Lightday calculators collection

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

--[[
  Reference:

    paper "A model comparison for daylength as function of latitude
      and day of the year"

      journal "Ecological Modelling"
        issue 80 (year 1995)
]]

-- Export:
return
  {
    bgc = request('bgc.interface'),
    brock = request('brock.interface'),
    cbm = request('cbm.interface'),
    ceres = request('ceres.interface'),
  }

--[[
  2019
  2026-05-29
]]
