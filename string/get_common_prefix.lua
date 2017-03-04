return
  function(s1, s2)
    local len = math.min(#s1, #s2)
    local result
    local idx_finish = len
    for i = 1, len do
      if (s1:sub(i, i) ~= s2:sub(i, i)) then
        idx_finish = i - 1
        break
      end
    end
    result = s1:sub(1, idx_finish)
    return result, idx_finish + 1
  end
