local chunk_name = 'qd'

--[[
  This is not secure method. But very simple and fast.
--]]

local table_from_string =
  function(table_str)
    local chunk = '_table = ' .. table_str
    -- print(chunk)
    local f, err_msg = load(chunk)
    if is_nil(f) then
      error(err_msg)
    end
    f()
    return _table
  end

tribute(chunk_name, table_from_string)
