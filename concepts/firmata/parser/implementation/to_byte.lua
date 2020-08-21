-- Convert one 7-bit and 1-bit integers to byte.

local assert_byte = request('!.number.assert_byte')

return
  function(self, b0, b1)
    local result = self:to_word(b0, b1)
    assert_byte(result)
    return result
  end
