local parser = request('!.mechs.parser')
local handy = parser.handy

local long_quote_pattern = request('^.^.^.long_quote_pattern')

return
  function(stream)
    local start_pos = stream:get_position()
    local has_open_match = stream:match_regexp('^' .. long_quote_pattern.start)
    if has_open_match then
      local len = stream:get_position() - start_pos
      local start_quote = stream:get_segment(start_pos, len)

      local finish_quote = start_quote:gsub('%[', ']')
      local has_close_match = stream:match_regexp('^.-' .. finish_quote)
      if has_close_match then
        return true
      else
        stream:set_position(start_pos)
      end
    end
  end
