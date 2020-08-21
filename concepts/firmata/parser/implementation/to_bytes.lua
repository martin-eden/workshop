return
  function(self, s)
    assert_string(s)
    local result = self:to_8bit_string(s)
    result = {result:byte(1, -1)}
    return result
  end
