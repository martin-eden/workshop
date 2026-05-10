-- Bits Value interface

--[[
  Author: Martin Eden
  Last mod.: 2026-05-11
]]

--[[
  Data structure

    Value [i]
]]

--[[
  Interface (alias "me")

    GetValue ( me )
    GetRangeValue ( me range )
    Add ( me value data_len )

    SetRangeValue ( me range value )

    create ( value )
]]

-- Imports:
local get_bits = request('!.number.get_bits')
local set_bits = request('!.number.set_bits')
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
      function(Me, value, data_len)
        Me.Value = (Me.Value << data_len) | value
      end,
    SetRangeValue =
      function(Me, Range, value)
        Me.Value =
          set_bits(
            value,
            Range:GetStart() - 1,
            Range:GetStop() - 1,
            Me.Value
          )
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
  2026-05-10
]]
