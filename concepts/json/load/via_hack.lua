-- Parse JSON

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

--[[
  Implementation adjusts JSON string to string with Lua table
  definition and executes that string as code.

  Hacky: fast, simple, dirty, dangerous.
]]

-- Imports:
local str_as_lua_table = request('^.^.lua_table.load')

local parse_json =
  function(json_str)
    if not is_string(json_str) then
      return
    end

    local result = json_str
    result = string.gsub(result, '%[', '{')
    result = string.gsub(result, '%]', '}')
    result = string.gsub(result, '"([^"]+)"%s*:', '["%1"]=')
    result = str_as_lua_table(result)

    return result
  end

-- Export:
return parse_json

--[[
  2017
  2026-05-05
]]
