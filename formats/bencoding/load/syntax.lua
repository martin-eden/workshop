local handy = request('!.mechs.processor.handy')

local opt = handy.opt
local rep = handy.rep
local cho = handy.cho

local eat_digits =
  function(stream)
    local init_pos = stream:get_position()
    if stream:match_regexp('^%d+') then
      local len = stream:get_position() - init_pos
      return stream:get_segment(init_pos, len)
    end
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

local link = request('!.mechs.processor.link')
link(value)

return dictionary
