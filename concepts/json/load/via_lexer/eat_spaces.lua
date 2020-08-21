return
  function(self, s, cur_pos)
    local result, new_pos = self.lexer.is_spaces(s, cur_pos)
    return new_pos
  end
