--[[
  Split string in pieces.

  Gets source string with delimiter and delimiter string.
  Returns table with sequence of pieces, without delimiter string.
  Delimiter may not be present at end of string. So result for
  ('a;b', ';') is same as for ('a;b;', ';').

  Input:
    s: string - source string
    opt delim: string - delimiter string
      default: "\n"

  Output:
    table - list of strings
]]

return
  function(s, delim)
    assert_string(s)
    local delim = delim or '\n'
    assert_string(delim)
    local result = {}
    local last_pos = 1
    for line, _last_pos in string.gmatch(s, '(.-)' .. delim .. '()') do
      result[#result + 1] = line
      last_pos = _last_pos
    end
    result[#result + 1] = s:sub(last_pos)
    return result
  end
