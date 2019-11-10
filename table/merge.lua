return
  function(t_dest, t_src)
    assert_table(t_dest)
    if (t_src == nil) then
      return t_dest
    end

    assert_table(t_src)
    for k, v in pairs(t_src) do
      t_dest[k] = v
    end

    return t_dest
  end
