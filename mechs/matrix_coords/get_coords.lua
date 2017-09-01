--[[
  Return coord record for linear index.

  No checks.
]]

local get_coords = request('!.bare.geometry.2d.matrix.idx_to_coord')

return
  function(self, index)
    local row, column =
      get_coords(
        index,
        self.index_base,
        self.num_columns,
        self.rows_base,
        self.columns_base
      )
    return {y = row, x = column}
  end
