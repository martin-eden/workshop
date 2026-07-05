-- Point in 1-d range

--[[
  Author: Martin Eden
  Last mod.: 2026-07-05
]]

-- Imports:
local create_instance = request('!.table.create_instance')
local min = math.min
local max = math.max

--[[
  Data storage format

    1 [i] Current value
    2 [i] Minimum value
    3 [i] Maximum value
]]
local Core = { 0, 0, 5 }

local Interface
Interface =
  {
    GetCurValue = function(Me) return Me[1] end,
    SetCurValue = function(Me, val) Me[1] = val end,

    GetMinValue = function(Me) return Me[2] end,
    SetMinValue = function(Me, val) Me[2] = val end,

    GetMaxValue = function(Me) return Me[3] end,
    SetMaxValue = function(Me, val) Me[3] = val end,

    GetValue =
      function(Me)
        local cur_value = Me:GetCurValue()
        local min_value = Me:GetMinValue()
        local max_value = Me:GetMaxValue()

        return max(min(cur_value, max_value), min_value)
      end,
    SetValue =
      function(Me, arg_value)
        local cur_value
        local min_value = Me:GetMinValue()
        local max_value = Me:GetMaxValue()

        cur_value = max(min(arg_value, max_value), min_value)

        Me:SetCurValue(cur_value)
      end,

    IncBy =
      function(Me, value)
        Me:SetCurValue(Me:GetCurValue() + value)
      end,
    DecBy =
      function(Me, value)
        Me:SetCurValue(Me:GetCurValue() - value)
      end,

    Inc =
      function(Me)
        Me:IncBy(1)
      end,
    Dec =
      function(Me)
        Me:DecBy(1)
      end,

    create =
      function(OptCore)
        return create_instance(OptCore or Core, Interface)
      end,
  }

-- Export:
return Interface

--[[
  2026-05-11
  2026-07-05
]]
