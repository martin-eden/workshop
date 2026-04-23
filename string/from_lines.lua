-- Concatenate sequence of strings

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

--[[
  Concatenate strings with newline separator. Tailing newline.
]]
local LinesToString =
  function(Lines)
    assert_table(Lines)

    local Result
    local Separator = '\n'

    Result = table.concat(Lines, Separator)
    Result = Result .. Separator

    return Result
  end

-- Export:
return LinesToString

--[[
  Good design is not about implementing complex things.
  Good design is providing uniform interface to many things.

  2024-02-28, 2024-03-02
]]

--[[
  2024-02-28
  2026-04-17
]]
