-- Create file with given pathname and contents

--[[
  Author: Martin Eden
  Last mod.: 2026-09-14
]]

local open_file = request('open')
local close_file = request('close')

-- Export:
return
  function(pathname, contents)
    assert_string(pathname)
    assert_string(contents)

    local File = open_file(pathname, 'wb')
    File:write(contents)
    close_file(File)
  end

--[[
  2024 #
  2026 #
]]
