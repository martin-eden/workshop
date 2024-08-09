-- Merge one table onto another

--[[
  Merge(Dest, Src)
  ~~~~~~~~~~~~~~~~
    for E in AnyOf(Src)
      AddTo(Dest, E)

    return Dest // ?
]]

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

--[[
  2016-06
  2016-09
  2019-12
  2024-08
]]
