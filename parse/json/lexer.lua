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

local last_pos
local last_token
local our_s
local cur_pos

local space_chars =
  {
    [' '] = true,
    ['\n'] = true,
    ['\r'] = true,
    ['\t'] = true,
  }

local eat_spaces =
  function()
    while space_chars[our_s:sub(cur_pos, cur_pos)] do
      cur_pos = cur_pos + 1
    end
    return 'spaces'
  end

local eat_null =
  function()
    if (our_s:sub(cur_pos, cur_pos + #'null' - 1) == 'null') then
      cur_pos = cur_pos + #'null'
      return 'null'
    end
  end

local eat_true =
  function()
    if (our_s:sub(cur_pos, cur_pos + #'true' - 1) == 'true') then
      cur_pos = cur_pos + #'true'
      return 'boolean'
    end
  end

local eat_false =
  function()
    if (our_s:sub(cur_pos, cur_pos + #'false' - 1) == 'false') then
      cur_pos = cur_pos + #'false'
      return 'boolean'
    end
  end

--[[
  Numbers in JSON must start with digit. If first digit is "0" then
  it must be sole digit in integer part. Optional "-" sign allowed.
]]

local eat_number =
  function()
    local start_pos, finish_pos
    if (our_s:sub(cur_pos, cur_pos) == '-') then
      cur_pos = cur_pos + 1
    end
    if (our_s:sub(cur_pos, cur_pos) == '0') then
      cur_pos = cur_pos + 1
    else
      start_pos, finish_pos = our_s:find('^[%d]+', cur_pos)
      if not finish_pos then
        return
      end
      cur_pos = finish_pos + 1
    end
    start_pos, finish_pos = our_s:find('^%.[%d]+', cur_pos)
    if finish_pos then
      cur_pos = finish_pos + 1
    end
    start_pos, finish_pos = our_s:find('^[eE][%+%-]?[%d]+', cur_pos)
    if finish_pos then
      cur_pos = finish_pos + 1
    end
    return 'number'
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
  function()
    local start_pos, finish_pos
    if (our_s:sub(cur_pos, cur_pos) ~= '"') then
      return
    else
      cur_pos = cur_pos + 1
    end
    while true do
      start_pos, finish_pos = our_s:find([[^[^%c%\%"]+]], cur_pos)
      if not finish_pos then
        local cur_char = our_s:sub(cur_pos, cur_pos)
        if (cur_char == '"') then
          cur_pos = cur_pos + 1
          break
        elseif (cur_char == [[\]]) then
          cur_pos = cur_pos + 1
          local next_char = our_s:sub(cur_pos, cur_pos)
          if escape_next_chars[next_char] then
            cur_pos = cur_pos + 1
          elseif (next_char == 'u') then
            -- Four hex. digits of UTF codepoint. (f.e. "\uA0b2")
            local start_pos, finish_pos =
              our_s:find(
                '[%dabcdefABCDEF][%dabcdefABCDEF][%dabcdefABCDEF][%dabcdefABCDEF]'
              )
            if not finish_pos then
              return
            else
              cur_pos = finish_pos + 1
            end
          else
            return
          end
        else
          return
        end
      else
        cur_pos = finish_pos + 1
      end
    end
    return 'string'
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

local get_token =
  function()
    last_pos = cur_pos
    local handler = handler_by_first_char[our_s:sub(cur_pos, cur_pos)]
    if (type(handler) == 'string') then
      cur_pos = cur_pos + 1
      last_token = handler
    elseif handler then
      last_token = handler()
    else
      last_token = nil
    end
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

local create_is_func =
  function(syntel_name)
    return
      function(s, s_pos)
        if (s_pos ~= last_pos) or (s ~= our_s) then
          our_s = s
          cur_pos = s_pos
          get_token()
        end
        if (last_token == syntel_name) then
          return true, cur_pos
        end
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

local init =
  function(s)
    our_s = s
    cur_pos = 1
  end

local get_state =
  function()
    return last_token, last_pos, cur_pos
  end

result.test =
  {
    init = init,
    get_state = get_state,
    get_token = get_token,
  }

return result
