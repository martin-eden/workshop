-- Check that integer is ASCII control code

--[[
  Author: Martin Eden
  Last mod.: 2026-08-07
]]

-- Imports:
local assert_byte = request('!.number.assert_byte')

local is_control_code =
  function(code)
    assert_byte(code)

    return (code <= 31) or (code == 127)
  end

-- Export:
return is_control_code

--[[
  2026-08-01
  2026-08-07
]]
