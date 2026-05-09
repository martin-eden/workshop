-- String Value interface

--[[
  Author: Martin Eden
  Last mod.: 2026-05-10
]]

--[[
  Data structure

    Value [s]
    EmptyChar [s] -- character for empty space
]]

--[[
  Interface (alias "me")

    SetValue ( me value )
    GetValue ( me )

    GetRangeValue ( me range )
    Add ( me value data_len )

    SetDefaultItemValue ( me empty_char )
    GetDefaultItemValue ( me )
    SetRangeValue ( me range value )

    create ( )
]]

-- Imports:
local attach_methods = request('!.table.attach_methods')

local Interface
Interface =
  {
    SetValue =
      function(Me, str)
        assert_string(str)

        Me.Value = str
      end,
    GetValue =
      function(Me)
        assert_string(Me.Value)

        return Me.Value
      end,
    GetRangeValue =
      function(Me, Range)
        return
          string.sub(Me:GetValue(), Range:GetStart(), Range:GetStop())
      end,
    Add =
      function(Me, value, data_len)
        Me:SetValue(Me:GetValue() .. value)
      end,
    SetDefaultItemValue =
      function(Me, empty_char)
        assert_string(empty_char)
        assert(string.len(empty_char) == 1)

        Me.EmptyChar = empty_char
      end,
    GetDefaultItemValue =
      function(Me)
        assert_string(Me.EmptyChar)

        return Me.EmptyChar
      end,
    SetRangeValue =
      function(Me, DataRange, value)
        --[[
          If range is out of our string, we will extend string with
          empty char.
        ]]

        local our_value = Me:GetValue()
        local empty_char = Me:GetDefaultItemValue()
        local our_value_len = string.len(our_value)
        local range_end_pos = DataRange:GetStop()

        if (our_value_len < range_end_pos) then
          local delta_len = range_end_pos - our_value_len
          local dummy_str = string.rep(empty_char, delta_len)
          our_value = our_value .. dummy_str
        end

        Me:SetValue(
          string.sub(our_value, 1, DataRange:GetStart() - 1) ..
          string.sub(value, 1, DataRange:GetLength()) ..
          string.sub(our_value, DataRange:GetStop() + 1, our_value_len)
        )
      end,

    create =
      function()
        local Result = { Value = '', EmptyChar = '?' }

        attach_methods(Result, Interface)

        return Result
      end,
  }

-- Export:
return Interface

--[[
  2026-05-02
  2026-05-07
  2026-05-09
  2026-05-10
]]
