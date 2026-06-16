-- Return string with Lua table describing Wrappers arg

--[[
  Author: Martin Eden
  Last mod.: 2026-06-16
]]

-- Imports:
local table_to_str = request('!.convert.table_to_str')
local trim_head = request('!.string.trim_head')

local get_wrappers_text =
  function(Wrappers)
    local result =
      table_to_str(
        Wrappers, { c_text_block = { next_line_indent = 2 } }
      )

    return trim_head(result)
  end

-- Export:
return get_wrappers_text

--[[
  2018
  2026-06-16
]]
