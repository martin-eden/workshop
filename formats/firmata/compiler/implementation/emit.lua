local assert_byte = request('!.number.assert_byte')

return
  function(...)
    local num_terms = select('#', ...)
    for i = 1, num_terms do
      local term = select(i, ...)
      assert_byte(term)
      local char = string.char(term)
      io.write(char)
    end
  end
