-- Concatenate sequence of lines to single string

--[[
  Input

    table -- sequence of strings without newlines

  Output

    string - concatenated string from sequence, separated by newlines.
      NB: There is always tail newline at result string.
]]

-- Last mod.: 2024-02-29

--[[
  Good design is not about avoiding implementing simple things.
  Good design is providing uniform interface to any things.

  2024-02-28
]]

return
  function(Lines)
    assert_table(Lines)

    local Result = ''

    Result = table.concat(Lines, '\n')

    Result = Result .. '\n'

    return Result
  end
