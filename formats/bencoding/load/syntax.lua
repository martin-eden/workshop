local parser = request('!.mechs.parser')
local handy = parser.handy

local opt = handy.opt
local rep = handy.rep
local cho = handy.cho

local string_len
local string_len_pattern = '^(%d+)'
local remember_string_len =
  function(s, s_pos)
    local start, finish, digs = s:find(string_len_pattern, s_pos)
    if start then
      string_len = tonumber(digs)
      return true, finish + 1
    end
  end

local get_string =
  function(s, s_pos)
    if string_len and (s_pos + string_len - 1 <= #s) then
      return true, s_pos + string_len
    end
  end

local string =
  {
    remember_string_len, ':', {name = 'string', get_string},
  }

local integer =
  {
    'i', {name = 'integer', opt('-'), handy.match_pattern('%d+')}, 'e',
  }

local dictionary =
  {
    'd',
    {
      name = 'dictionary',
      opt(rep(string, '>value'))
    },
    'e',
  }

local list =
  {
    'l', {name = 'list', opt(rep('>value'))}, 'e',
  }

local value =
  {
    inner_name = 'value',
    cho(string, integer, list, dictionary)
  }

parser.link(dictionary, {value = value})

return dictionary
