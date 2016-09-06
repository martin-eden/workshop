local is_array_smart =
  function(t)
    local result
    if is_table(t) then
      result = true
      for k in pairs(t) do
        if not is_integer(k) then
          result = false
          break
        end
      end
    end
    return result
  end

return is_array_smart
