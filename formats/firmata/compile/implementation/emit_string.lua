local emit = request('emit')
local assert_byte = request('!.number.assert_byte')

return
  function(s)
    assert_string(s)
    for i = 1, #s do
      local char_code = s:byte(i, i)
      assert_byte(char_code)
      emit(char_code & 0x7F, char_code >> 7)
    end
  end
