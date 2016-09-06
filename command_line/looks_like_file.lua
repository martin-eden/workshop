-- Tries to refuse strings like '--verbose' as file name

local looks_like_file =
  function(s)
    local result
    if is_string(s) and (#s > 0) then
      result = (s:sub(1, 1) ~= '-')
    end
    return result
  end

return looks_like_file
