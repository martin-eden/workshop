return
  function(self, max_num_points)
    assert_integer(max_num_points)
    assert(max_num_points >= 1)
    self.max_num_points = max_num_points
    self.points = {}
  end
