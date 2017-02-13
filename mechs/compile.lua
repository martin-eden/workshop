local unfold = request('^.table.unfold')

return
  function(t)
    assert_table(t)
    local result = {}

    local compile
    compile =
      function(node)
        if is_string(node) then
          result[#result + 1] = node
        elseif is_table(node) then
          for i = 1, #node do
            compile(node[i])
          end
        end
      end

    compile(t)
    result = unfold(result)

    return table.concat(result)
  end
