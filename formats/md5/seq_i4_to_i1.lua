return
  function(seq, receiver)
    local result = receiver or {}
    for i = 1, #seq do
      local i4 = seq[i]
      for j = 1, 4 do
        result[#result + 1] = i4 & 0xFF
        i4 = i4 >> 8
      end
    end
    return result
  end
