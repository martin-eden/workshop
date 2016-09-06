-- This is not secure method. But very simple and fast.

local table_from_string =
  function(table_str)
    local result
    local chunk = 'return ' .. table_str
    -- print(chunk)
    local f, err_msg = load(chunk)
    if f then
      result = f()
    end
    return result
  end

return table_from_string
