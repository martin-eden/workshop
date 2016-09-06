local chunk_name = 'lua_identifier'

local keywords = request('lua_keywords')

local looks_like_lua_name =
  function(s)
    return
      is_string(s) and
      s:match('^[%a_][%w_]*$') and
      not keywords[s]
  end

tribute(chunk_name, looks_like_lua_name)
