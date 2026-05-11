-- String indent

--[[
  Author: Martin Eden
  Last mod.: 2026-05-11
]]

-- Imports:
local create_instance = request('!.table.create_instance')
local RangePointClass = request('!.concepts.RangePoint')

local Core

local RangePoint = RangePointClass.create()
RangePoint.min_value = 0
RangePoint.max_value = 60
RangePoint.value = 0

Core =
  {
    indent_chunk = '  ',
    RangePoint = RangePoint,
  }

local Interface
Interface =
  {
    ToString =
      function(Me)
        return string.rep(Me.indent_chunk, Me:GetRangePoint():GetValue())
      end,

    Inc =
      function(Me)
        Me:GetRangePoint():Inc()
      end,
    Dec =
      function(Me)
        Me:GetRangePoint():Dec()
      end,

    create =
      function(OptCore)
        return create_instance(OptCore or Core, Interface)
      end,

    GetRangePoint =
      function(Me)
        return Me.RangePoint
      end,
  }

-- Export:
return Interface

--[[
  2026-05-11
]]
