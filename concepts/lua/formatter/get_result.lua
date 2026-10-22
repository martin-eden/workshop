-- Return string with formatted Lua code from AST

--[[
  Author: Martin Eden
  Last mod.: 2026-10-22
]]

local add_to_list = request('!.concepts.list.add_item')
local lines_to_str = request('!.convert.lines_to_str')
local t2s = request('!.convert.table_to_str')

return
  function(Me)
    local Lines = { }

    print(t2s(Me.printer))

    add_to_list(Lines, Me.printer:GetText())
    add_to_list(Lines, Me.data_struc.unparsed_tail)
    if not Me.is_ok then
      add_to_list(Lines, '<no_valid_representation>')
    end

    return lines_to_str(Lines)
  end

--[[
  2018
  2026-07-17
]]
