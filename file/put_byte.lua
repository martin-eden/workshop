--[[
  Helper function.

  Write one byte to file object.
]]

local AssertByte = request('!.number.assert_byte')

return
  function(OutputStream, Byte)
    AssertByte(Byte)

    local Char = string.char(Byte)

    return OutputStream:write(Char)
  end
