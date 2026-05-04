-- Convert list of bytes to string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

local bytes_to_str =
  function(Bytes)
    -- This implementation is not designed for long lists

    assert_table(Bytes)

    return string.char(table.unpack(Bytes))
  end

-- Export:
return bytes_to_str

--[[
  2026-05-04
]]
