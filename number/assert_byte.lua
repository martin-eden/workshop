--[[
  Assert that passed value is integer in byte range.
]]

local is_byte = request('is_byte')

return
  function(v)
    assert(is_byte(v))
  end
