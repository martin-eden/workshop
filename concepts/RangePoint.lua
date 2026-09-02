-- Point in 1-d range

--[[
  Author: Martin Eden
  Last mod.: 2026-09-02
]]

--[[
  Data storage format

    1 [i] Current value
    2 [i] Minimum value
    3 [i] Maximum value
]]

local Interface

local create
do
  local DefaultCore = { 0, 0, 5 }
  local create_instance = request('!.table.create_instance')
  create =
    function(OptCore)
      return create_instance(OptCore or DefaultCore, Interface)
    end
end

local min = math.min
local max = math.max

Interface =
  {
    create = create,

    GetMinValue = function(Me) return Me[2] end,
    SetMinValue = function(Me, val) Me[2] = val end,

    GetMaxValue = function(Me) return Me[3] end,
    SetMaxValue = function(Me, val) Me[3] = val end,

    GetValue =
      function(Me)
        local min_value = Me:GetMinValue()
        local max_value = Me:GetMaxValue()

        return min(max(Me[1], min_value), max_value)
      end,
    SetValue =
      function(Me, arg_value)
        local min_value = Me:GetMinValue()
        local max_value = Me:GetMaxValue()

        Me[1] = min(max(arg_value, min_value), max_value)
      end,

    IncBy =
      function(Me, value)
        Me[1] = Me[1] + value
      end,
    DecBy =
      function(Me, value)
        Me[1] = Me[1] - value
      end,

    Inc =
      function(Me)
        Me:IncBy(1)
      end,
    Dec =
      function(Me)
        Me:DecBy(1)
      end,
  }

-- Export:
return Interface

--[[
  2026 # #
  2026-09-02
]]
