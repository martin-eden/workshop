return
  function(data_struc)
    assert_table(data_struc)
    local result =
      {
        code = {},
        comments = {},
      }
    for i = 1, #data_struc do
      if (data_struc[i].type == 'code') then
        result.code[#result.code + 1] = data_struc[i].value
      elseif (data_struc[i].type == 'comment') then
        result.comments[#result.comments + 1] = data_struc[i].value
      end
    end
    result.code = table.concat(result.code)
    result.comments = table.concat(result.comments, '\n')
    return result
  end
