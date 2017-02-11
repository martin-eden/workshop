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

local plain_string_chars = [[^[^%c%\%"]+]]
local four_hex_digs = '^' .. ('[0-9a-fA-F]'):rep(4)

return
  function(s, s_pos)
    local start_pos, finish_pos
    if (s:sub(s_pos, s_pos) ~= '"') then
      return
    else
      s_pos = s_pos + 1
    end
    while true do
      start_pos, finish_pos = s:find(plain_string_chars, s_pos)
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
            local start_pos, finish_pos = s:find(four_hex_digs, s_pos + 1)
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
