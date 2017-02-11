return
  function(self, s, cur_pos)
    local is_ok

    cur_pos = self:eat_spaces(s, cur_pos)
    is_ok, cur_pos = self.lexer.is_open_bracket(s, cur_pos)
    if not is_ok then
      return
    end

    local result = {}
    local is_dangling_comma
    local key = 0
    while true do
      cur_pos = self:eat_spaces(s, cur_pos)
      local array_value
      is_ok, array_value, cur_pos = self:load_value(s, cur_pos)
      if not is_ok then
        if is_dangling_comma then
          return
        else
          break
        end
      end
      key = key + 1
      result[key] = array_value

      cur_pos = self:eat_spaces(s, cur_pos)
      is_ok, cur_pos = self.lexer.is_comma(s, cur_pos)
      if not is_ok then
        is_dangling_comma = nil
        break
      end
      is_dangling_comma = true
    end

    is_ok, cur_pos = self.lexer.is_close_bracket(s, cur_pos)
    if not is_ok then
      return
    end

    return is_ok, result, cur_pos
  end
