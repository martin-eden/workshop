return
  function(self, s, cur_pos)
    local is_ok

    cur_pos = self:eat_spaces(s, cur_pos)
    is_ok, cur_pos = self.lexer.is_open_brace(s, cur_pos)
    if not is_ok then
      return
    end

    local result = {}
    local is_dangling_comma
    while true do
      local term_start_pos

      cur_pos = self:eat_spaces(s, cur_pos)
      term_start_pos = cur_pos
      is_ok, cur_pos = self.lexer.is_string(s, cur_pos)
      if not is_ok then
        if is_dangling_comma then
          return
        else
          break
        end
      end
      local obj_key = self:process_string(s:sub(term_start_pos, cur_pos - 1))

      cur_pos = self:eat_spaces(s, cur_pos)
      is_ok, cur_pos = self.lexer.is_colon(s, cur_pos)
      if not is_ok then
        return
      end

      cur_pos = self:eat_spaces(s, cur_pos)
      local obj_value
      is_ok, obj_value, cur_pos = self:load_value(s, cur_pos)
      if not is_ok then
        return
      end

      result[obj_key] = obj_value

      cur_pos = self:eat_spaces(s, cur_pos)
      is_ok, cur_pos = self.lexer.is_comma(s, cur_pos)
      if not is_ok then
        is_dangling_comma = nil
        break
      end
      is_dangling_comma = true
    end

    is_ok, cur_pos = self.lexer.is_close_brace(s, cur_pos)
    if not is_ok then
      return
    end

    return is_ok, result, cur_pos
  end
