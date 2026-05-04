-- Check for file (or directory) presence

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local normalize_name = request('normalize_name')

local pathname_exists =
  function(pathname)
    assert_string(pathname)

    pathname = normalize_name(pathname)

    local file = io.open(pathname, 'rb')

    local result = not is_nil(file)

    if result then
      file:close()
    end

    return result
  end

-- Export:
return pathname_exists

--[[
  2016
  2026-05-04
]]
