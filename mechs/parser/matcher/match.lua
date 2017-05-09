return
  function(self, rule)
    local rule_type = type(rule)
    if (rule_type == 'table') then
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
    elseif (rule_type == 'string') then
      return self.value:match(rule)
    elseif (rule_type == 'function') then
      return rule(self.value)
    end
  end
