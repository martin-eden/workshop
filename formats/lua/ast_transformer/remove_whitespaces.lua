local remove_whitespaces
remove_whitespaces =
  function(node)
    assert_table(node)
    for i = #node, 1, -1 do
      if (node[i].type == 'whitespace') then
        table.remove(node, i)
      end
    end
    for i = #node, 1, -1 do
      if is_table(node[i]) then
        remove_whitespaces(node[i])
      end
    end
  end

return
  function(self)
    return remove_whitespaces(self.data_struc)
  end
