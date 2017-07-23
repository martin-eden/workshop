return
  function(block, block_name)
    assert_table(block)
    assert_string(block_name)
    print(('%s:'):format(block_name))
    for i = 1, #block do
      print(('[%02d] "%s"'):format(i, block[i]))
    end
  end
