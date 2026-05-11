-- Point in 1-d range

--[[
  Author: Martin Eden
  Last mod.: 2026-05-11
]]

-- Imports:
local create_instance = request('!.table.create_instance')

local Core
Core =
  {
    value = 0,
    min_value = 0,
    max_value = 5,
  }

local Interface
Interface =
  {
    IncBy =
      function(Me, value)
        Me:SetValue(Me:GetValue() + value)
      end,
    DecBy =
      function(Me, value)
        Me:SetValue(Me:GetValue() - value)
      end,

    create =
      function(OptCore)
        return create_instance(OptCore or Core, Interface)
      end,

    Inc =
      function(Me)
        Me:IncBy(1)
      end,
    Dec =
      function(Me)
        Me:DecBy(1)
      end,

    GetValue =
      function(Me)
        return math.max(math.min(Me.value, Me.max_value), Me.min_value)
      end,
    SetValue =
      function(Me, value)
        Me.value = math.max(math.min(value, Me.max_value), Me.min_value)
      end,
  }

-- Export:
return Interface

--[[
  2026-05-11
]]
