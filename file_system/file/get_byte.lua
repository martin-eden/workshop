--[[
  Helper function.

  Read one character from file object. If it's not the end
  of file, return character as byte (0x00 .. 0xFF).
]]

return
  function(InputStream)
    local Result

    local c = InputStream:read(1)

    if is_nil(c) then
      return
    end

    Result = c:byte()

    return Result
  end
