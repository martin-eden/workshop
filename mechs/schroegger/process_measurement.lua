return
  function(self, cur_point)
    local points = self.points
    local num_points = self:get_num_points()

    local next_point_delta
    local start_point
    local last_point

    if (num_points > 0) then
      start_point = points[0]
      last_point = points[num_points - 1]
      next_point_delta = (last_point - start_point) / (num_points - 1)
    else
      start_point = 0
      last_point = 0
      next_point_delta = 0
    end

    if (cur_point < last_point + next_point_delta) then
      return
    end
    if (num_points == self.max_num_points) then
      next_point_delta = (cur_point - start_point) / (num_points - 1)
      num_points = self:squeeze(next_point_delta)
    end
    points[num_points] = cur_point
    num_points = num_points + 1
  end
