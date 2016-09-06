--[[
  Library Genesis contents is presented also in .csv format.
  But string fields there written bad. They do not have double
  quotes to escape quote in data. Looks like their quote() function
  is like

    return '"' .. field_data .. '"'

  And so there is fields like

    ["From Randomized Algorithms to "PRIMES Is in P""]

  To fix it we need to determine field borders.

  As a partially correct approach we check that after "closing" quote
  is "," or NL. If not, that quote is not closing and we escape it
  with other quote. No whitespaces after " awaited. So for
  ["str" ,123] we transform it to ["str"" ,123] and will whine that
  there is no closing quote. (This is done because in my case there
  is no border spaces in unquoted fields.)

  There is clash in cases like [""a","b","c""]. It may mean
  ["a","b","c"] but also may be ["a][b][c"]. This code fixes such
  strings to first variant.

  But we may handle [""a", "b", "c""] if we reverse source
  string before parsing (and reverse result string after).
]]

local fix_bad_line =
  function(s)
    local state = 'waiting'
    local result_str = ''
    local is_succeeded = true
    for i = 1, #s do
      local char = s:sub(i, i)
      -- print(('%-16s %3s %s'):format(state, char, result_str))
      if (char == '"') then
        if (state == 'waiting') then
          state = 'in_string'
          result_str = result_str .. char
        elseif (state == 'in_string') then
          state = 'wait_next_char'
        elseif (state == 'wait_next_char') then
          -- hopefully correctly quoted quote
          result_str = result_str .. char
          state = 'next_is_delim'
        elseif (state == 'next_is_delim') then
          result_str = result_str .. char
          state = 'in_string'
        elseif (state == 'unquoted_field') then
          -- sorrow! We made mistake in our guessings earlier
          is_succeeded = false
          break
        end
      elseif (char == ',') then
        if (state == 'waiting') then
          result_str = result_str .. char
        elseif (state == 'in_string') then
          result_str = result_str .. char
        elseif (state == 'unquoted_field') then
          result_str = result_str .. char
          state = 'waiting'
        elseif (state == 'wait_next_char') then
          result_str = result_str .. '"' .. ','
          state = 'waiting'
        elseif (state == 'next_is_delim') then
          result_str = result_str .. char
          state = 'waiting'
        end
      else
        if (state == 'in_string') then
          result_str = result_str .. char
        elseif (state == 'wait_next_char') then
          result_str = result_str .. '""' .. char
          state = 'in_string'
        elseif (state == 'next_is_delim') then
          result_str = result_str .. '"' .. char
          state = 'in_string'
        elseif (state == 'waiting') then
          result_str = result_str .. char
          state = 'unquoted_field'
        elseif (state == 'unquoted_field') then
          result_str = result_str .. char
        end
      end
    end
    -- print(('%-16s %3s %s'):format(state, char, result_str))
    if (state == 'wait_next_char') then
      result_str = result_str .. '"'
    end

    return is_succeeded, result_str
  end

local try_reversed =
  function(s)
    s = s:reverse()
    local is_succeeded, fixed_s = fix_bad_line(s)
    fixed_s = fixed_s:reverse()
    return is_succeeded, fixed_s
  end

local fix_bad_line_outer =
  function(s)
    if (s:sub(-1, -1) == '\n') then
      s = s:sub(1, -2)
    end
    if (s:sub(-1, -1) == '\r') then
      s = s:sub(1, -2)
    end
    local is_succeeded, fixed_s
    is_succeeded, fixed_s = fix_bad_line(s)
    if not is_succeeded then
      is_succeeded, fixed_s = try_reversed(s)
      if not is_succeeded then
        is_succeeded, fixed_s = fix_bad_line(s)
        is_succeeded, fixed_s = try_reversed(fixed_s)
        if not is_succeeded then
          is_succeeded, fixed_s = try_reversed(s)
          is_succeeded, fixed_s = fix_bad_line(fixed_s)
        end
      end
    end
    return is_succeeded, fixed_s
  end

return fix_bad_line_outer
