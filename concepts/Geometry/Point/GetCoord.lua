return
  function(self, coord)
    coord = coord or 1
    assert_integer(coord)
    return self.Coords[coord]
  end
