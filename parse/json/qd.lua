local chunk_name = 'qd'

--[[
  Just substitutes syntax in string with assumed JSON code to Lua syntax.
  This is not safe, not flexible and not universal method. But simple and
  very fast.
--]]

local table_from_lua_string = request('^.lua_table')

function json_as_table(json_str)
  if not is_string(json_str) then
    return
  end
  local result = json_str
  result = result:gsub('%[', '{')
  result = result:gsub('%]', '}')
  result = result:gsub('"([^"-]+)"%s+%:', '["%1"]=')
  result = table_from_lua_string(result)
  return result
end

tribute(chunk_name, json_as_table)
