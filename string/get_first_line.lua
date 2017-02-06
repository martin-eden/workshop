return
  function(s)
    local lf_pos = s:find('\n', 1, true)
    if lf_pos then
      return s:sub(1, lf_pos - 1)
    else
      return s
    end
  end
