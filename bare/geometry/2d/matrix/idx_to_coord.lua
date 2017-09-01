--[[
  Convert linear index to matrix coordinates.

  Core function. No checks.
]]

return
  function(index, index_base, num_columns, rows_base, columns_base)
    index = index - index_base
    local row = index // num_columns + rows_base
    local column = index % num_columns + columns_base
    return row, column
  end
