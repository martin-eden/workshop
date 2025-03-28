-- Map table values to keys

--[[
  Useful when you want to check presence and have list.

    { 'A', _ = 'a'} -> { A = true, a = true }
]]

-- Last mod.: 2025-03-28

return
  function(t)
    assert_table(t)

    local Result = {}

    for k, v in pairs(t) do
      Result[v] = true
    end

    return Result
  end

--[[
  2016-09-06
  2024-10-20
  2025-03-28
]]
