--[[
  Return index for <coords> record.

  No checks.
]]

local get_index = request('!.mechs.geometry.2d.matrix.coord_to_idx')

return
  function(self, coords)
    return
      get_index(
        coords.y,
        self.rows_base,
        coords.x,
        self.columns_base,
        self.num_columns,
        self.index_base
      )
  end
