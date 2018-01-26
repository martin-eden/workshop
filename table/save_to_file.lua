--[[
  Save table to file as lua code.

  Input: <file_name> <table>
  Output: none

  Notes

    Supports cross-linked tables.

    Lua code is indented and wrapped at right margin. So printable.
]]

local table_to_str = request('!.formats.lua_table_code.save')

local get_ast = request('!.lua.code.get_ast')
local get_code = request('!.lua.code.ast_as_code')

local format_code =
  function(s)
    return get_code(get_ast(s))
  end

local save_to_file = request('!.string.save_to_file')

return
  function(file_name, t)
    save_to_file(file_name, format_code(table_to_str(t)))
  end
