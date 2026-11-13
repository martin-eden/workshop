-- Convert list of bytes to string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

-- This implementation is not designed for long lists

local tbl_unpack = table.unpack
local str_char = string.char

return
  function(bytes)
    return str_char(tbl_unpack(bytes))
  end

--[[
  2026 #
]]
