-- Import/export functions for items

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local trim_tail_nls = request('!.string.trim_tail_nls')
local lines_from_str = request('!.convert.lines_from_str')
local lines_to_str = request('!.convert.lines_to_str')

-- Convert string to line value
local ToItem =
  function(Me, str)
    return trim_tail_nls(str)
  end

-- Explode string to list of lines
local FromString =
  function(Me, lines_str)
    Me.Items = lines_from_str(lines_str)
  end

-- Implode list of lines to string
local ToString =
  function(Me)
    return lines_to_str(Me.Items)
  end

-- Export:
return
  {
    ToItem = ToItem,

    FromString = FromString,
    ToString = ToString,
  }

--[[
  2026-04-26
]]
