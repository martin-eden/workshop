-- Concatenate sequence of lines to single string

--[[
  Input

    table -- sequence of strings without newlines

  Output

    string - concatenated string from sequence, separated by newlines

  Special case

    When sequence is just one element
      Result string has no tail newline
    When sequence is more than one element
      Result string has tail newline

    Illustration

      from_lines({'One-liner'}) -> "One-liner"
      from_lines({'Two-', 'liner'}) -> "Two-"" \n "liner" \n
]]

-- Last mod.: 2024-02-28

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

    -- Special case.
    if (#Lines > 1) then
      Result = Result .. '\n'
    end

    return Result
  end
