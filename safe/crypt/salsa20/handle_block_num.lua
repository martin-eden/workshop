return
  function(a_block_num)
    local result
    a_block_num = a_block_num or 1
    assert_integer(a_block_num)
    assert(a_block_num >= 0)
    result = {a_block_num & 0xFFFFFFFF, a_block_num >> 32}
    return result
  end
