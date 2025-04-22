-- Merge one table onto another

-- Last mod.: 2025-04-21

--[[
  Union:
    ({ a = 'A'}, { b = 'B' }) -> { a = 'A', b = 'B' }

  Source values preserved:
    ({ a = 'A'}, { a = 'a' }) -> { a = 'A' }
]]

local MergeTable
MergeTable =
  function(Result, Additions)
    assert_table(Result)
    if (Additions == nil) then
      return Result
    end

    assert_table(Additions)
    for Addition_Key, Addition_Value in pairs(Additions) do
      if is_nil(Result[Addition_Key]) then
        Result[Addition_Key] = Addition_Value
      elseif is_table(Result[Addition_Key]) then
        MergeTable(Result[Addition_Key], Addition_Value)
      end
    end

    return Result
  end

-- Exports:
return MergeTable

--[[
  2016-06
  2016-09
  2017-09
  2019-12
  2024-08
  2025-04-21
]]
