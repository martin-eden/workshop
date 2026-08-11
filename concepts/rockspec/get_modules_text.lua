-- Return string with Lua table describing Modules arg

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

-- Imports:
local tree_to_str = request('!.convert.tree_to_str')
local trim_head = request('!.string.trim_head')
local Lines = request('!.concepts.Lines.Interface')

local get_modules_text =
  function(Modules)
    local result = tree_to_str(Modules)

    local Lines = new(Lines)
    Lines:FromString(result)
    Lines:Indent()
    result = Lines:ToString()

    return trim_head(result)
  end

-- Export:
return get_modules_text

--[[
  2018
  2026-06-16
  2026-08-11
]]
