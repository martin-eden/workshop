-- Return string with Lua table describing Wrappers arg

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

-- Imports:
local tree_to_str = request('!.convert.tree_to_str')
local trim_head = request('!.string.trim_head')
local Lines = request('!.concepts.Lines.Interface')

local get_wrappers_text =
  function(Wrappers)
    local result = tree_to_str(Wrappers)

    local Lines = new(Lines)
    Lines:FromString(result)
    Lines:Indent()
    Lines:Indent()
    result = Lines:ToString()

    return trim_head(result)
  end

-- Export:
return get_wrappers_text

--[[
  2018
  2026-06-16
  2026-08-11
]]
