local str_as_lua_table = request('^.^.lua_table.load')

return
  function(json_str)
    if not is_string(json_str) then
      return
    end
    local result = json_str
    result = result:gsub('%[', '{')
    result = result:gsub('%]', '}')
    result = result:gsub('"([^"]+)"%s*:', '["%1"]=')
    result = str_as_lua_table(result)
    return result
  end
