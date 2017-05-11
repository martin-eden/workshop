return
  function(self, pattern)
    -- print(('match_regexp [%d, "%s"]'):format(self:get_position(), pattern))
    local start, finish = self.s:find(pattern, self:get_position())
    if start then
      self:set_position(finish + 1)
      return self.s:sub(start, finish)
    end
  end
