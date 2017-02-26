return
  function(self, rule)
    assert(rule)
    if is_string(rule) then
      return self.value:match(rule)
    elseif is_function(rule) then
      return rule(self.value)
    elseif is_table(rule) then
      local mode = rule.mode or 'seq'
      local handler = self.handlers[mode]
      local init_position = self.value:get_position()
      local result = handler(self, rule)
      if not result then
        self.value:set_position(init_position)
      else
        if rule.name then
          local cur_position = self.value:get_position()
          self:on_match(init_position, cur_position, rule.name)
        end
      end
      return result
    end
  end
