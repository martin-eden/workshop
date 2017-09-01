return
  function(a_num_rounds)
    local result
    a_num_rounds = a_num_rounds or 20
    assert_integer(a_num_rounds)
    assert(a_num_rounds >= 0)
    assert(a_num_rounds % 2 == 0, '<num_rounds> must be even number.')
    result = a_num_rounds // 2
    return result
  end
