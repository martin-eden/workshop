return
  function(t_dest, t_src)
    assert_table(t_dest)
    assert_table(t_src)
    for k, v in pairs(t_dest) do
      t_src[k] = v
    end
  end
