return
  function(self, s, cur_pos)
    local new_pos

    local cur_token, new_pos = self.lexer.get_token(s, cur_pos)
    if not cur_token then
      return
    end

    local result = s:sub(cur_pos, new_pos - 1)

    local is_ok = true

    if (cur_token == 'number') then
      result = self:process_number(result)
    elseif (cur_token == 'string') then
      result = self:process_string(result)
    elseif (cur_token == 'open_bracket') then
      is_ok, result, new_pos = self:load_array(s, cur_pos)
    elseif (cur_token == 'open_brace') then
      is_ok, result, new_pos = self:load_object(s, cur_pos)
    elseif (cur_token == 'boolean') then
      result = self:process_boolean(result)
    elseif (cur_token == 'null') then
      result = self:process_null(result)
    else
      is_ok = false
    end

    if is_ok then
      return is_ok, result, new_pos
    else
      return false, nil, cur_pos
    end
  end
