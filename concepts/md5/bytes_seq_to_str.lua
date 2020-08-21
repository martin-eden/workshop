return
  function(seq)
    local result = {}
    for i = 1, #seq do
      result[i] = ('%02X'):format(seq[i])
    end
    result = table.concat(result)
    return result
  end
