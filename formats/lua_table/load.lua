-- This is not secure method. But very simple and fast.

return
  function(table_str)
    local result
    local chunk = 'return ' .. table_str
    local f, err_msg = load(chunk)
    if f then
      result = f()
    end
    return result
  end
