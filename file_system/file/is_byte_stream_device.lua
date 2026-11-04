-- Check that file represents "character device" (think UART)

--[[
  Author: Martin Eden
  Last mod.: 2026-11-04
]]

local is_byte_stream =
  request('!.mechs.cmdline.get_cmd_is_byte_stream_device')

return
  function(pathname)
    return (is_byte_stream(pathname):Execute())
  end

--[[
  2026 11-04
]]
