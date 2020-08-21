local extract_date_re = '.+  +(.*)$'

return
  function(block)
    local date_str = block[#block]
    date_str = date_str:match(extract_date_re)
    return date_str
  end
