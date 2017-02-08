--[[
  Well, I've implemented JSON loader with traditional lexer-parser
  scheme. This code is just boring and not too fast, 7.48s where
  DkJson gives 4.47 (67% slower).

  It was nor fun nor challende to write it. But has done it as
    * need fast own parser
    * wished sample to profile and compare performance with
      parser-without-lexer.

  Anyway I'm not going to write such sort of code further. This is
  monkey job.
]]

local lexer = request('^.parse.lexer')

local eat_spaces =
  function(s, cur_pos)
    local result, new_pos = lexer.is_spaces(s, cur_pos)
    return new_pos
  end

local process_null =
  function(s)
    return nil
  end

local process_boolean =
  function(s)
    return (s == 'true')
  end

local process_number =
  function(s)
    return tonumber(s)
  end

local unquote_string = request('^.unquote_string')
local process_string =
  function(s)
    return unquote_string(s)
  end

local load_array
local load_object

local load_value =
  function(s, cur_pos)
    local new_pos

    local cur_token, new_pos = lexer.get_token(s, cur_pos)
    if not cur_token then
      return
    end

    local result = s:sub(cur_pos, new_pos - 1)

    local is_ok = true

    if (cur_token == 'number') then
      result = process_number(result)
    elseif (cur_token == 'string') then
      result = process_string(result)
    elseif (cur_token == 'open_bracket') then
      is_ok, result, new_pos = load_array(s, cur_pos)
    elseif (cur_token == 'open_brace') then
      is_ok, result, new_pos = load_object(s, cur_pos)
    elseif (cur_token == 'boolean') then
      result = process_boolean(result)
    elseif (cur_token == 'null') then
      result = process_null(result)
    end

    return is_ok, result, new_pos
  end

load_array =
  function(s, cur_pos)
    local is_ok

    cur_pos = eat_spaces(s, cur_pos)
    is_ok, cur_pos = lexer.is_open_bracket(s, cur_pos)
    if not is_ok then
      return
    end

    local result = {}
    local is_dangling_comma
    local key = 0
    while true do
      cur_pos = eat_spaces(s, cur_pos)
      local array_value
      is_ok, array_value, cur_pos = load_value(s, cur_pos)
      if not is_ok then
        if is_dangling_comma then
          return
        else
          break
        end
      end
      key = key + 1
      result[key] = array_value

      cur_pos = eat_spaces(s, cur_pos)
      is_ok, cur_pos = lexer.is_comma(s, cur_pos)
      if not is_ok then
        is_dangling_comma = nil
        break
      end
      is_dangling_comma = true
    end

    cur_pos = eat_spaces(s, cur_pos)
    is_ok, cur_pos = lexer.is_close_bracket(s, cur_pos)
    if not is_ok then
      return
    end

    return is_ok, result, cur_pos
  end

load_object =
  function(s, cur_pos)
    local is_ok

    cur_pos = eat_spaces(s, cur_pos)
    is_ok, cur_pos = lexer.is_open_brace(s, cur_pos)
    if not is_ok then
      return
    end

    local result = {}
    local is_dangling_comma
    while true do
      local term_start_pos

      cur_pos = eat_spaces(s, cur_pos)
      term_start_pos = cur_pos
      is_ok, cur_pos = lexer.is_string(s, cur_pos)
      if not is_ok then
        if is_dangling_comma then
          return
        else
          break
        end
      end
      local obj_key = process_string(s:sub(term_start_pos, cur_pos - 1))

      cur_pos = eat_spaces(s, cur_pos)
      is_ok, cur_pos = lexer.is_colon(s, cur_pos)
      if not is_ok then
        return
      end

      cur_pos = eat_spaces(s, cur_pos)
      local obj_value
      is_ok, obj_value, cur_pos = load_value(s, cur_pos)
      if not is_ok then
        return
      end

      result[obj_key] = obj_value

      cur_pos = eat_spaces(s, cur_pos)
      is_ok, cur_pos = lexer.is_comma(s, cur_pos)
      if not is_ok then
        is_dangling_comma = nil
        break
      end
      is_dangling_comma = true
    end

    cur_pos = eat_spaces(s, cur_pos)
    is_ok, cur_pos = lexer.is_close_brace(s, cur_pos)
    if not is_ok then
      return
    end

    return is_ok, result, cur_pos
  end

local load =
  function(s)
    local is_ok, result = load_object(s, 1)
    if is_ok then
      return result
    end
  end

return load
