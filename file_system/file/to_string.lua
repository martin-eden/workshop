-- Return file's contents as string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local open_file = request('open')

local load_file_contents =
  function(pathname)
    local File = open_file(pathname, 'rb')
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
