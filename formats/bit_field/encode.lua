--[[
  Encode string with 0/1 characters to string sequence of bytes.

  Currently only byte granularity is planned to support.

  Implementation is naive. For heavy load we need to create lookup
  table.
]]

local bits = {['0'] = 0, ['1'] = 1}

local bit_str_to_byte =
  function(s)
    local result = 0
    for i = 1, 8 do
      result = (result << 1) | bits[s:sub(i, i)]
    end
    result = string.char(result)
    return result
  end

return
  function(bit_str)
    assert_string(bit_str)
    assert(#bit_str % 8 == 0)
    local result
    result = bit_str:gsub('........', bit_str_to_byte)
    return result
  end
