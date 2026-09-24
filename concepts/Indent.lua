-- String indent

--[[
  Author: Martin Eden
  Last mod.: 2026-09-24
]]

--[[
  Data storage format

    1 [s] Indent chunk
    2 [t] Range point with current indent level
]]

local get_indent_chunk =
  function(Me)
    return Me[1]
  end

local set_indent_chunk =
  function(Me, str)
    Me[1] = str
  end

local get_indent_level =
  function(Me)
    return Me[2]:GetValue()
  end

local set_indent_level =
  function(Me, level)
    Me[2]:SetValue(level)
  end

local to_string
do
  local str_rep = string.rep
  to_string =
    function(Me)
      return str_rep(Me[1], Me[2]:GetValue())
    end
end

local inc =
  function(Me)
    set_indent_level(Me, get_indent_level(Me) + 1)
  end

local dec =
  function(Me)
    set_indent_level(Me, get_indent_level(Me) - 1)
  end

local Interface
local create
do
  local RangePointClass = request('!.concepts.RangePoint')
  local default_indent_chunk = '  '
  local default_max_indent = 60
  local attach_methods = request('!.table.attach_methods')
  create =
    function()
      local RangePoint = RangePointClass.create()
      RangePoint:SetMinValue(0)
      RangePoint:SetMaxValue(default_max_indent)
      RangePoint:SetValue(0)

      local Core = { default_indent_chunk, RangePoint }
      attach_methods(Core, Interface)

      return Core
    end
end

Interface =
  {
    create = create,

    GetIndentChunk = get_indent_chunk,
    SetIndentChunk = set_indent_chunk,

    GetIndentLevel = get_indent_level,
    SetIndentLevel = set_indent_level,

    ToString = to_string,

    Inc = inc,
    Dec = dec,
  }

-- Export:
return Interface

--[[
  2026 # #
  2026-09-24
]]
