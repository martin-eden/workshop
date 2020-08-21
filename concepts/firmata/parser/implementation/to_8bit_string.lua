return
  function(self, s)
    assert_string(s)
    assert(#s % 2 == 0)
    local result = {}
    for c_low, c_high in s:gmatch('(.)(.)') do
      local code_low = c_low:byte()
      assert(code_low <= 0x7F)
      local code_high = c_high:byte()
      assert(code_high <= 1)
      local code = code_low | (code_high << 7)
      table.insert(result, string.char(code))
    end
    result = table.concat(result)
    return result
  end
