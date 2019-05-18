local to_8bit_string = request('to_8bit_string')

return
  function(s)
    assert_string(s)
    local result = to_8bit_string(s)
    result = {result:byte(1, -1)}
    return result
  end
