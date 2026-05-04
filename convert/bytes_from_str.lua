-- Convert string to list of bytes

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

local bytes_from_str =
  function(str)
    -- This implementation is not designed for long strings

    assert_string(str)

    return { string.byte(str, 1, string.len(str)) }
  end

-- Export:
return bytes_from_str

--[[
  2026-05-04
]]
