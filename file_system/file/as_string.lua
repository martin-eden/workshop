-- Return file's contents as string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local safe_open = request('safe_open')
local normalize_name = request('normalize_name')

local load_file_contents =
  function(pathname)
    assert_string(pathname)

    pathname = normalize_name(pathname)

    local f = safe_open(pathname, 'rb')
    local result = f:read('a')
    f:close()

    return result
  end

-- Export:
return load_file_contents

--[[
  2016 # #
  2019 #
  2026-05-04
]]
