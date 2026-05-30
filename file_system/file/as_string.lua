-- Return file's contents as string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local safe_open = request('safe_open')

local load_file_contents =
  function(pathname)
    assert_string(pathname)

    local File = safe_open(pathname, 'rb')
    local result = File:read('a')
    File:close()

    return result
  end

-- Export:
return load_file_contents

--[[
  2016 # #
  2019 #
  2026-05-04
  2026-05-30
]]
