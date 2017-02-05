local cached_pos
local token_type
local our_s
local cur_pos

local space_chars =
  {
    [' '] = true,
    ['\n'] = true,
    ['\r'] = true,
    ['\t'] = true,
  }

local skip_spaces =
  function()
    while space_chars[our_s:sub(cur_pos, cur_pos)] do
      cur_pos = cur_pos + 1
    end
  end

--[[
  You can get type of JSON token just by analyzing first char
  after spaces.
]]

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
      return 'true'
    end
  end

local eat_false =
  function()
    if (our_s:sub(cur_pos, cur_pos + #'false' - 1) == 'false') then
      cur_pos = cur_pos + #'false'
      return 'false'
    end
  end

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
          cur_pos = cur_char + 1
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
  }

local get_token =
  function()
    local handler = handler_by_first_char[our_s:sub(cur_pos, cur_pos)]
    if (type(handler) == 'string') then
      cur_pos = cur_pos + 1
      return handler
    elseif handler then
      return handler()
    end
  end

local get_next_token =
  function()
    skip_spaces()
    token_type = get_token()
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
  }

local spawn_get_functions =
  function()
    local result = {}
    for i = 1, #json_syntels do
      local func_name = ('get_%s'):format(json_syntels[i])
      local func =
        function(s, s_pos)
          if (s_pos ~= cached_pos) or (s ~= our_s) then
            our_s = s
            cur_pos = s_pos
            cached_pos = cur_pos
            get_next_token()
          end
          if (token_type == json_syntels[i]) then
            return true, cur_pos
          end
        end
      result[func_name] = func
    end
    return result
  end

local init =
  function(s)
    our_s = s
    cur_pos = 1
    -- print(('s: [%s]'):format(our_s))
  end

local print_cur_state =
  function()
    -- print(('[%s]: %s'):format(cur_pos, token_type))
    return token_type
  end

local result = spawn_get_functions()
result.test =
  {
    init = init,
    print_cur_state = print_cur_state,
    get_next_token = get_next_token,
  }

return result
