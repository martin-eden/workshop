local get_bit = request('!.number.get_bit')

return
  function(value)
    assert_integer(value)

    local result = 0
    for i = 63, 0, -1 do
      if get_bit(value, i) then
        result = i
        break
      end
    end

    return result
  end
