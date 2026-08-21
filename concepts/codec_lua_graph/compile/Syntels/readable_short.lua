-- Readable-short syntax elements

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
        item_separator = ', ',
        start_table = '{ ',
        end_table = ' }',
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
