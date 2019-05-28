local assert_byte = request('!.number.assert_byte')
local emit = request('emit')

return
  function(self, ...)
    local num_terms = select('#', ...)
    for i = 1, num_terms do
      local term = select(i, ...)
      assert_byte(term)
      self:emit(term & 0x7F, term >> 7)
    end
  end
