local max_right_margin = 70

return
  function(self, representation)
    local text_width = representation:get_width()
    local text_height = representation:get_height()

    local result
    result = (text_width <= max_right_margin)

    return result
  end
