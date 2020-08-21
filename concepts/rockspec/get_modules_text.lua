local table_to_string = request('!.formats.lua_table.save')
local trim_head = request('!.string.trim_head')

return
  function(modules)
    local result
    result =
      table_to_string(
        modules,
        {c_text_block = {next_line_indent = 1}}
      )
    result = trim_head(result)
    return result
  end
