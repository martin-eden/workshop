-- Range methods

--[[
  Author: Martin Eden
  Last mod.: 2026-05-09
]]

--[[
  Data structure

    Start [i]
    Length [i]
]]

--[[
  Interface

    GetStart
    GetStop
    GetLength

    create ( start length )
]]

-- Imports:
local is_natural_num = request('!.number.is_natural')
local attach_methods = request('!.table.attach_methods')

local Interface
Interface =
  {
    GetStart =
      function(Range)
        return Range.Start
      end,
    GetStop =
      function(Range)
        return Range.Start + Range.Length - 1
      end,
    GetLength =
      function(Range)
        return Range.Length
      end,

    create =
      function(start, length)
        assert(is_natural_num(start))
        assert(is_natural_num(length))

        local Range = { Start = start, Length = length }

        attach_methods(Range, Interface)

        return Range
      end
  }

-- Export:
return Interface

--[[
  2026-04-30
  2026-05-01
  2026-05-03
  2026-05-09
]]
