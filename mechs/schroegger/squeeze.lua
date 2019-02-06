return
  function(self, next_point_delta)
    local num_points = self:get_num_points()
    if (num_points <= 1) then
      return 0
    end
    local points = self.points
    local deletion_idx = self:get_deletion_idx(next_point_delta)
    for i = deletion_idx, (num_points - 2) do
      points[i] = points[i + 1]
    end
    return (num_points - 1)
  end
