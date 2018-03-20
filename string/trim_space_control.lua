local trim_head =
  function(s)
    return s:gsub('^[%s%c]+', '')
  end

local trim_tail =
  function(s)
    return s:gsub('[%s%c]+$', '')
  end

return
  function(s)
    return trim_head(trim_tail(s))
  end
