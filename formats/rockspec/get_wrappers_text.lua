local table_to_string = request('!.formats.lua_table.save')
local trim_head = request('!.string.trim_head')

return
  function(wrappers)
    local result
    result =
      table_to_string(
        wrappers,
        {c_text_block = {next_line_indent = 2}}
      )
    result = trim_head(result)
    return result
  end
