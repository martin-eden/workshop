return
  function(self, next_point_delta)
    local num_points = self:get_num_points()
    local points = self.points
    local max_diff = {idx = 0, delta = 0}
    for i = 1, (num_points - 1) do
      local awaited_val = points[0] + next_point_delta * i
      local delta = math.abs(points[i] - awaited_val)
      if (delta > max_diff.delta) then
        max_diff.idx = i
        max_diff.delta = delta
      end
    end
    return max_diff.idx
  end
