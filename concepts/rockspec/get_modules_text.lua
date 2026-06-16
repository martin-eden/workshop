-- Return string with Lua table describing Modules arg

--[[
  Author: Martin Eden
  Last mod.: 2026-06-16
]]

-- Imports:
local table_to_str = request('!.convert.table_to_str')
local trim_head = request('!.string.trim_head')

local get_modules_text =
  function(Modules)
    local result =
      table_to_str(
        Modules, { c_text_block = { next_line_indent = 1 } }
      )

    return trim_head(result)
  end

-- Export:
return get_modules_text

--[[
  2018
  2026-06-16
]]
