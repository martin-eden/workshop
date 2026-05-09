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
  Interface (alias "me")

    GetStart ( me )
    GetStop ( me )
    GetLength ( me )

    create ( start length )
]]

-- Imports:
local is_natural_num = request('!.number.is_natural')
local attach_methods = request('!.table.attach_methods')

local Interface
Interface =
  {
    GetStart =
      function(Me)
        return Me.Start
      end,
    GetStop =
      function(Me)
        return Me.Start + Me.Length - 1
      end,
    GetLength =
      function(Me)
        return Me.Length
      end,

    create =
      function(start, length)
        assert(is_natural_num(start))
        assert(is_natural_num(length))

        local Result = { Start = start, Length = length }

        attach_methods(Result, Interface)

        return Result
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
