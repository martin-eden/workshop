return
  function(t)
    local result
    if is_table(t) then
      result = 0
      for k in pairs(t) do
        result = result + 1
      end
    end
    return result
  end
