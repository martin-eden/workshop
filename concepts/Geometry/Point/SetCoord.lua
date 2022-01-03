return
  function(self, value, coord)
    coord = coord or 1
    assert_integer(coord)
    self.Coords[coord] = value
  end
