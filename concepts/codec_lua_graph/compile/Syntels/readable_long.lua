-- Readable-long syntax elements

--[[
  Author: Martin Eden
  Last mod.: 2026-08-22
]]

local Syntels
do
  local BaseSyntels = request('minimal')

  Syntels =
    new(
      BaseSyntels,
      {
        assign = ' = ',
        empty_table = '{ }',
      }
    )
end

-- Export:
return Syntels

--[[
  2026-08-15
  2026-08-22
]]
