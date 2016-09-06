local chunk_name = 'qd'

--[[
  This is not secure method. But very simple and fast.
--]]

local table_from_string =
  function(table_str)
    local f = load('_table = ' .. table_str)
    f()
    return _table
  end

tribute(chunk_name, table_from_string)
