-- String hack to quickly load JSON object as lua table.

--[[
  Just converts syntax in string with JSON code to Lua table syntax.
  This is not safe, not flexible and not universal method. But simple
  and very fast. (It's about 45 times faster than my JSON parser.)

  You will got bad-formed lua table if you JSON have strings with
  "\/", "\u".

    (
      In JSON strings both "\/" and "/" means "/". Also "\\" means "\".
      So we can't just replace "\/" to "/" as it converts "\\/" (means
      "\/") to "\/" (means "/").
    )
    (
      "\u" and 4 hex digits in JSON string means UTF code point.
      Since Lua5.3 they can be mapped to lua strings with simple
      replace. (v5.3 introduced "\u{" <hex_code> "}" string
      construct.) But I'm not going to implement it as I have
      normal parser.
    )

  Again, this is not secure! I belive arbitrary lua code execution
  possible at time of load of "lua table". I'm not going to yell that
  fire is hot, I assume you understand mechanics of things you use.

  Use normal parser if this hack fails.
--]]

local str_as_lua_table = request('^.lua.serialize_table.lua_table')

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
