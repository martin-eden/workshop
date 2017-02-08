--[[
  This is JSON lexer.

  This module task is to export quick boolean functions

    is_null
    is_boolean,
    ...
    (see <json_syntels> sequence for full list)

  for use in [parser] grammar.

  Each function is called with parameters <s>, <s_pos> with parsing
  string and start position in it. If function succeeds it returns
  "true" and new start position.

  Previous call results cached in <last_pos> and <last_token>.
  As it is typical in grammar to iterate all possible tokens at
  fixed positions.

  For performance reasons this module is not represented as class.
  (To allow referencing <last_pos> as upvalue, not via "self" table.)
]]

local space_chars =
  {
    [' '] = true,
    ['\n'] = true,
    ['\r'] = true,
    ['\t'] = true,
  }

local eat_spaces =
  function(s, s_pos)
    if space_chars[s:sub(s_pos, s_pos)] then
      repeat
        s_pos = s_pos + 1
      until not space_chars[s:sub(s_pos, s_pos)]
      return 'spaces', s_pos
    end
  end

local eat_null =
  function(s, s_pos)
    if (s:sub(s_pos, s_pos + #'null' - 1) == 'null') then
      return 'null', s_pos + #'null'
    end
  end

local eat_true =
  function(s, s_pos)
    if (s:sub(s_pos, s_pos + #'true' - 1) == 'true') then
      return 'boolean', s_pos + #'true'
    end
  end

local eat_false =
  function(s, s_pos)
    if (s:sub(s_pos, s_pos + #'false' - 1) == 'false') then
      return 'boolean', s_pos + #'false'
    end
  end

--[[
  Numbers in JSON must start with digit. If first digit is "0" then
  it must be sole digit in integer part. Optional "-" sign allowed.
]]

local eat_number =
  function(s, s_pos)
    local start_pos, finish_pos
    if (s:sub(s_pos, s_pos) == '-') then
      s_pos = s_pos + 1
    end
    if (s:sub(s_pos, s_pos) == '0') then
      s_pos = s_pos + 1
    else
      start_pos, finish_pos = s:find('^[%d]+', s_pos)
      if not finish_pos then
        return
      end
      s_pos = finish_pos + 1
    end
    start_pos, finish_pos = s:find('^%.[%d]+', s_pos)
    if finish_pos then
      s_pos = finish_pos + 1
    end
    start_pos, finish_pos = s:find('^[eE][%+%-]?[%d]+', s_pos)
    if finish_pos then
      s_pos = finish_pos + 1
    end
    return 'number', s_pos
  end

local escape_next_chars =
  {
    [ [[\]]] = true,
    ['"'] = true,
    ['/'] = true,
    ['b'] = true,
    ['n'] = true,
    ['f'] = true,
    ['r'] = true,
    ['t'] = true,
  }

local eat_string =
  function(s, s_pos)
    local start_pos, finish_pos
    if (s:sub(s_pos, s_pos) ~= '"') then
      return
    else
      s_pos = s_pos + 1
    end
    while true do
      start_pos, finish_pos = s:find([[^[^%c%\%"]+]], s_pos)
      if not finish_pos then
        local cur_char = s:sub(s_pos, s_pos)
        if (cur_char == '"') then
          s_pos = s_pos + 1
          break
        elseif (cur_char == [[\]]) then
          s_pos = s_pos + 1
          local next_char = s:sub(s_pos, s_pos)
          if escape_next_chars[next_char] then
            s_pos = s_pos + 1
          elseif (next_char == 'u') then
            -- Four hex. digits of UTF codepoint. (f.e. "\uA0b2")
            local start_pos, finish_pos =
              s:find(
                '[%dabcdefABCDEF][%dabcdefABCDEF][%dabcdefABCDEF][%dabcdefABCDEF]'
              )
            if not finish_pos then
              return
            else
              s_pos = finish_pos + 1
            end
          else
            return
          end
        else
          return
        end
      else
        s_pos = finish_pos + 1
      end
    end
    return 'string', s_pos
  end

--[[
  We can get type of JSON token just by analyzing first char
  after spaces.
]]

local handler_by_first_char =
  {
    ['['] = 'open_bracket',
    [']'] = 'close_bracket',
    ['{'] = 'open_brace',
    ['}'] = 'close_brace',
    [','] = 'comma',
    [':'] = 'colon',
    ['n'] = eat_null,
    ['t'] = eat_true,
    ['f'] = eat_false,
    ['-'] = eat_number,
    ['0'] = eat_number,
    ['1'] = eat_number,
    ['2'] = eat_number,
    ['3'] = eat_number,
    ['4'] = eat_number,
    ['5'] = eat_number,
    ['6'] = eat_number,
    ['7'] = eat_number,
    ['8'] = eat_number,
    ['9'] = eat_number,
    ['"'] = eat_string,
    [' '] = eat_spaces,
    ['\n'] = eat_spaces,
    ['\r'] = eat_spaces,
    ['\t'] = eat_spaces,
  }

local last_token
local last_pos
local last_s
local last_new_pos

local get_token =
  function(s, s_pos)
    if (s_pos ~= last_pos) or (s ~= last_s) then
      last_s = s
      last_pos = s_pos
      local handler = handler_by_first_char[s:sub(s_pos, s_pos)]
      if (type(handler) == 'string') then
        last_token, last_new_pos = handler, s_pos + 1
      elseif handler then
        last_token, last_new_pos = handler(s, s_pos)
      else
        return false, s_pos
      end
    end
    return last_token, last_new_pos
  end

local json_syntels =
  {
    'null',
    'boolean',
    'number',
    'string',
    'open_bracket',
    'close_bracket',
    'open_brace',
    'close_brace',
    'comma',
    'colon',
    'spaces',
  }
local quote = request('^.^.lua.transform.quote_string')
local create_is_func =
  function(syntel_name)
    return
      function(s, s_pos)
        local token, new_pos = get_token(s, s_pos)
        --[[
        print(
          ('[%d][%4s] requested %s, has %s'):
          format(
            s_pos,
            quote(s:sub(s_pos, s_pos + 3)),
            syntel_name, token
          )
        )
        --]]
        if (token == syntel_name) then
          return true, new_pos
        end
        return false, s_pos
      end
  end

local spawn_get_functions =
  function()
    local result = {}
    for i = 1, #json_syntels do
      local func_name = ('is_%s'):format(json_syntels[i])
      local func = create_is_func(json_syntels[i])
      result[func_name] = func
    end
    return result
  end

local result = spawn_get_functions()

local get_state =
  function()
    return last_token, last_pos, s_pos
  end

result.get_state = get_state
result.get_token = get_token

return result
