--[[
  Normalize coordinates.

  Next row after maximum row number is first row. Same for columns.

  No checks.
]]

local wrap_coord = request('!.mechs.geometry.1d.segments.wrap_coord')

return
  function(self, coords)
    coords.x = wrap_coord(coords.x, self.columns_base, self.num_columns)
    coords.y = wrap_coord(coords.y, self.rows_base, self.num_rows)
  end
