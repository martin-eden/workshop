-- Concatenate sequence of strings

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

-- Import:
local <const> IsNatural = request('!.number.is_natural')

--[[
  Concatenate strings with newline separator. Tailing newline.
]]
local <const> LinesToString =
  function(Lines, StartIdx, EndIdx)
    assert_table(Lines)
    assert(IsNatural(StartIdx))
    assert(IsNatural(EndIdx))
    assert(StartIdx <= EndIdx)
    assert(EndIdx <= #Lines)

    local Result
    local <const> Separator = '\n'

    Result = table.concat(Lines, Separator, StartIdx, EndIdx)
    Result = Result .. '\n'

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
