-- Create Range instance

--[[
  Author: Martin Eden
  Last mod.: 2026-05-03
]]

--[[
  Data structure

    Start [i]
    Length [i]
]]

-- Imports:
local is_natural_num = request('!.number.is_natural')
local attach_methods = request('!.table.attach_methods')
local Methods = request('Methods')

local create =
  function(start, length)
    assert(is_natural_num(start))
    assert(is_natural_num(length))

    local Range =
      {
        Start = start,
        Length = length,
      }

    attach_methods(Range, Methods)

    return Range
  end

-- Export:
return create

--[[
  2026-05-02
  2026-05-03
]]
