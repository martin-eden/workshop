local slice_bits = request('!.number.slice_bits')

return
  function(self, ...)
    for i = 1, select('#', ...) do
      local term = select(i, ...)
      self:emit(slice_bits(term, 0, 6), slice_bits(term, 7, 13))
    end
  end
