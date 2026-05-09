-- Bits Value interface

--[[
  Author: Martin Eden
  Last mod.: 2026-05-10
]]

--[[
  Data structure

    Value [i]
]]

--[[
  Interface (alias "me")

    GetValue ( me )
    GetRangeValue ( me range )
    Add ( me me range )

    create ( value )
]]

-- Imports:
local get_bits = request('!.number.get_bits')
local attach_methods = request('!.table.attach_methods')

local Interface
Interface =
  {
    GetValue =
      function(Me)
        return Me.Value
      end,
    GetRangeValue =
      function(Me, Range)
        return
          get_bits(Me.Value, Range:GetStart() - 1, Range:GetStop() - 1)
      end,
    Add =
      function(Me, Data, DataRange)
        Me.Value =
          (Me.Value << DataRange:GetLength()) | Data:GetRangeValue(DataRange)
      end,

    create =
      function(value)
        value = value or 0

        assert_integer(value)

        local Result = { Value = value }

        attach_methods(Result, Interface)

        return Result
      end,
  }

-- Export:
return Interface

--[[
  2026-05-02
  2026-05-09
]]
