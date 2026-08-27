-- String indent

--[[
  Author: Martin Eden
  Last mod.: 2026-08-27
]]

-- Imports:
local create_instance = request('!.table.create_instance')
local RangePoint = request('!.concepts.RangePoint')
local str_rep = string.rep

local RangePoint = RangePoint.create()
RangePoint:SetMinValue(0)
RangePoint:SetMaxValue(60)
RangePoint:SetValue(RangePoint:GetMinValue())

--[[
  Data storage format

    1 [s] Indent chunk
    2 [t] Range point of current indent level
]]
local Core =
  {
    '  ',
    RangePoint,
  }

local Interface
Interface =
  {
    GetIndentChunk = function(Me) return Me[1] end,
    SetIndentChunk =
      function(Me, str)
        assert_string(str)

        Me[1] = str
      end,

    GetRangePoint = function(Me) return Me[2] end,

    ToString =
      function(Me)
        local indent_level = Me:GetRangePoint():GetValue()

        if (indent_level == 0) then return '' end

        local indent_chunk = Me:GetIndentChunk()

        return str_rep(indent_chunk, indent_level)
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
