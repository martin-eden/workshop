-- Return list segment as list

--[[
  Author: Martin Eden
  Last mod.: 2026-05-02
]]

-- Imports:
local is_natural = request('!.number.is_natural')

local select_range =
  function(List, start_idx, stop_idx)
    assert(is_natural(start_idx))
    assert(is_natural(stop_idx))
    assert(start_idx <= stop_idx)

    local Result = { }

    table.move(List, start_idx, stop_idx, 1, Result)

    return Result
  end

-- Export:
return select_range

--[[
  2026-05-02
]]
