-- Create file with given pathname and contents

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local safe_open = request('safe_open')

local create_file =
  function(pathname, contents)
    assert_string(pathname)
    assert_string(contents)

    local file = safe_open(pathname, 'wb')

    file:write(contents)

    file:close()
  end

-- Export:
return create_file

--[[
  2024
  2026-05-04
]]
