local parser = request('!.mechs.parser')
local handy = parser.handy

local opt = handy.opt
local rep = handy.rep
local cho = handy.cho

local eat_digits =
  function(stream)
    local result = ''
    while true do
      local c = stream:read(1)
      if (c >= '0') and (c <= '9') then
        result = result .. c
      else
        stream:set_position(stream:get_position() - 1)
        break
      end
    end
    if (result == '') then
      result = nil
    end
    return result
  end

local string_len
local remember_string_len =
  function(stream)
    local digs = eat_digits(stream)
    if digs then
      string_len = tonumber(digs)
      return true
    else
      string_len = nil
    end
  end

local get_string =
  function(stream)
    if string_len then
      stream:set_relative_position(string_len)
      return true
    end
  end

local string =
  {remember_string_len, ':', {name = 'string', get_string}}

local integer =
  {'i', {name = 'integer', opt('-'), eat_digits}, 'e'}

local dictionary =
  {'d', {name = 'dictionary', opt(rep(string, '>value'))}, 'e'}

local list =
  {'l', {name = 'list', opt(rep('>value'))}, 'e'}

local value =
  {inner_name = 'value', cho(string, integer, list, dictionary)}

parser.link(dictionary, {value = value})
parser.link(dictionary)

return dictionary
