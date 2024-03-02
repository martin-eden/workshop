-- Concatenate sequence of lines to single string

--[[
  Input

    table

      Sequence of strings without newlines

  Output

    string

      Concatenated string from sequence, separated by newlines.
      Result string will always end with newline.
]]

-- Last mod.: 2024-03-02

--[[
  Good design is not about implementing complex things.
  Good design is providing uniform interface to many things.

  2024-02-28, -03-02
]]

return
  function(Lines)
    assert_table(Lines)

    local Result = ''

    Result = table.concat(Lines, '\n')

    Result = Result .. '\n'

    return Result
  end

--[[
  2024-02-28
]]
