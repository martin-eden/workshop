local get_lua_code_result =
  function(s)
    local f = load(s)
    local result
    if f then
      result = f()
    end
    return result
  end

return get_lua_code_result
