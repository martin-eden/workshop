return
  function(self, rule)
    local init_position = self.value:get_position()
    for i = 1, #rule do
      if self:match(rule[i]) then
        return true
      end
      self.value:set_position(init_position)
    end
  end
