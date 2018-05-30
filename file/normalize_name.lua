--[[
  Normalize string with Unix path-name.

  "/.////a" -> "a"
]]

local parse_pathname = request('!.formats.path_name.parse')

return
  function(path_name)
    local result = parse_pathname(path_name)
    result = result.directory .. result.name
    return result
  end
