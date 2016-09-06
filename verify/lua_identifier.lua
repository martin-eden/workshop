local chunk_name = 'lua_identifier'

local looks_like_lua_name =
  function(s)
    return
      is_string(s) and
      s:match('^[%a_][%w_]*$')
  end

tribute(chunk_name, looks_like_lua_name)
