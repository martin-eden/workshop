-- Convert string to table with sequence of lines

--[[
  Sequence of lines is useful if you want to add/remove lines
  and pass it further to chain.
]]

-- Last mod.: 2024-02-29

local LinesIterator = request('!.string.lines')

return
  function(s)
    assert_string(s)

    local Result = {}

    for NextReadIdx, Line in LinesIterator(s) do
      table.insert(Result, Line)
    end

    return Result
  end
