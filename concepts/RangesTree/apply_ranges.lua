-- Select data subsegments from input data and add them to output data

--[[
  Author: Martin Eden
  Last mod.: 2026-05-03
]]

--[[
  Input

    * Input data object
    * Ranges list
    * Output data object

  Action

    Select data ranges from input data and add them to output data
]]
local apply_ranges =
  function(InputData, Ranges, OutputData)
    for idx, Range in ipairs(Ranges) do
      OutputData:Add(InputData, Range)
    end
  end

-- Export:
return apply_ranges

--[[
  2026-05-02
  2026-05-03
]]
