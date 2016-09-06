local keywords = request('keywords')

local looks_like_lua_name =
  function(s)
    return
      is_string(s) and
      s:match('^[%a_][%w_]*$') and
      not keywords[s]
  end

return looks_like_lua_name
