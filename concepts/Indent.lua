-- String indent

--[[
  Author: Martin Eden
  Last mod.: 2026-07-05
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
    '  ',
    RangePoint = RangePoint,
  }

local Interface
Interface =
  {
    GetIndentChunk =
      function(Me)
        return Me[1]
      end,

    SetIndentChunk =
      function(Me, str)
        assert_string(str)

        Me[1] = str
      end,

    GetRangePoint =
      function(Me)
        return Me.RangePoint
      end,

    ToString =
      function(Me)
        local indent_chunk = Me:GetIndentChunk()
        local indent_level = Me:GetRangePoint():GetValue()

        return string.rep(indent_chunk, indent_level)
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
  }

-- Export:
return Interface

--[[
  2026-05-11
  2026-07-05
]]
