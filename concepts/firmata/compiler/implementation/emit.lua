local assert_byte = request('!.number.assert_byte')

return
  function(self, ...)
    local num_terms = select('#', ...)
    for i = 1, num_terms do
      local term = select(i, ...)
      assert_byte(term)
      local char = string.char(term)
      self.output:write(char)
    end
  end
