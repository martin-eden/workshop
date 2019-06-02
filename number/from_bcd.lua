local slice_bits = request('slice_bits')

return
  function(v)
    return slice_bits(v, 4, 7) * 10 + slice_bits(v, 0, 3)
  end
