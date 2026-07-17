-- Return string with formatted Lua code from AST

--[[
  Author: Martin Eden
  Last mod.: 2026-07-17
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')
local lines_to_str = request('!.convert.lines_to_str')

local get_code_str =
  function(Me)
    local Lines = { }

    add_to_list(Lines, Me.printer:get_text())
    add_to_list(Lines, Me.data_struc.unparsed_tail)
    if not Me.is_ok then
      add_to_list(Lines, '<no_valid_representation>')
    end

    return lines_to_str(Lines)
  end

-- Export:
return get_code_str

--[[
  2018
  2026-07-17
]]
