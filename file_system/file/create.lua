-- Create file with given pathname and contents

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local normalize_name = request('normalize_name')

local file_mode = 'wb'

local create_file =
  function(pathname, contents)
    assert_string(pathname)
    assert_string(contents)

    pathname = normalize_name(pathname)

    local file, error_str = io.open(pathname, file_mode)

    if not file then
      error(error_str)
    end

    file:write(contents)

    file:close()
  end

-- Export:
return create_file

--[[
  2024
  2026-05-04
]]
