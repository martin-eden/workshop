--[[
  Lookup table with dates per month for ordinary and leap year.
]]

return
  {
    [false] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
    [true] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
  }
