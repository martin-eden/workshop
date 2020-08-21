-- Tries to refuse strings like '--verbose' as file name

return
  function(s)
    local result
    if is_string(s) and (#s > 0) then
      result = (s:sub(1, 1) ~= '-')
    end
    return result
  end
