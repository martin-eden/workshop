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

local lexer = request('lexer')

local eat_spaces =
  function(s, cur_pos)
    local result, new_pos = lexer.is_spaces(s, cur_pos)
    return new_pos
  end

local load_null =
  function(s, cur_pos)
    local result, new_pos = lexer.is_null(s, cur_pos)
    if result then
      result = s:sub(cur_pos, new_pos - 1)
    end
    return result, new_pos
  end

local load_boolean =
  function(s, cur_pos)
    local result, new_pos = lexer.is_boolean(s, cur_pos)
    if result then
      result = s:sub(cur_pos, new_pos - 1)
    end
    return result, new_pos
  end

local load_number =
  function(s, cur_pos)
    local result, new_pos = lexer.is_number(s, cur_pos)
    if result then
      result = s:sub(cur_pos, new_pos - 1)
      result = tonumber(result)
    end
    return result, new_pos
  end

local unquote_string = request('unquote_string')
local load_string =
  function(s, cur_pos)
    local result, new_pos = lexer.is_string(s, cur_pos)
    if result then
      result = s:sub(cur_pos, new_pos - 1)
      result = unquote_string(result)
    end
    return result, new_pos
  end

local load_array
local load_object

local load_value =
  function(s, cur_pos)
    local result, new_pos

    lexer.is_string(s, cur_pos)
    local cur_token = lexer.get_state()

    if (cur_token == 'string') then
      result, new_pos = load_string(s, cur_pos)
    elseif (cur_token == 'number') then
      result, new_pos = load_number(s, cur_pos)
    elseif (cur_token == 'open_bracket') then
      result, new_pos = load_array(s, cur_pos)
    elseif (cur_token == 'open_brace') then
      result, new_pos = load_object(s, cur_pos)
    elseif (cur_token == 'boolean') then
      result, new_pos = load_boolean(s, cur_pos)
    elseif (cur_token == 'null') then
      result, new_pos = load_null(s, cur_pos)
    end

    return result, new_pos
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
    while true do
      cur_pos = eat_spaces(s, cur_pos)
      local array_value
      array_value, cur_pos = load_value(s, cur_pos)
      if not array_value then
        if is_dangling_comma then
          return
        else
          break
        end
      end
      result[#result + 1] = array_value

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

    return result, cur_pos
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
      cur_pos = eat_spaces(s, cur_pos)
      local obj_key
      obj_key, cur_pos = load_string(s, cur_pos)
      if not obj_key then
        if is_dangling_comma then
          return
        else
          break
        end
      end

      cur_pos = eat_spaces(s, cur_pos)
      is_ok, cur_pos = lexer.is_colon(s, cur_pos)
      if not is_ok then
        return
      end

      cur_pos = eat_spaces(s, cur_pos)
      local obj_value
      obj_value, cur_pos = load_value(s, cur_pos)
      if not obj_value then
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

    return result, cur_pos
  end

local load =
  function(s)
    local result = load_object(s, 1)
    return result
  end

return load
