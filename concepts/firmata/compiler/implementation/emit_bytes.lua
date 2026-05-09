local get_bits = request('!.number.get_bits')

return
  function(self, ...)
    for i = 1, select('#', ...) do
      local term = select(i, ...)
      self:emit(get_bits(term, 0, 6), get_bits(term, 7, 13))
    end
  end
