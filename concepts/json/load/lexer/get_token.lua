local eat_null = request('eat_null')
local eat_true = request('eat_true')
local eat_false = request('eat_false')
local eat_number = request('eat_number')
local eat_string = request('eat_string')
local eat_spaces = request('eat_spaces')

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

return
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
        last_token, last_new_pos = false, s_pos
      end
    end
    return last_token, last_new_pos
  end
