-- Set "executable" attribute for file

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local get_cmd_make_executable =
  request('!.mechs.cmdline.make_executable')

return
  function(pathname)
    return (get_cmd_make_executable(pathname):execute())
  end

--[[
  2026-11-11
]]
