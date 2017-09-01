--[[
  Convert row-column matrix coordinates to index in array.

  Core function. No checks.
]]

return
  function(row, rows_base, column, columns_base, num_columns, index_base)
    row = row - rows_base
    column = column - columns_base
    return row * num_columns + column + index_base
  end
