local table_to_str = request('!.formats.lua_table_code.save')

local get_ast = request('!.formats.lua.load')
local get_code = request('!.formats.lua.save')

local format_code =
  function(s)
    return get_code(get_ast(s))
  end

local safe_open = request('!.file.safe_open')

local save_to =
  function(fname, s)
    local f = safe_open(fname, 'w')
    f:write(s)
    f:close()
  end

return
  function(file_name, t)
    save_to(file_name, format_code(table_to_str(t)))
  end
