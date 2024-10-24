-- Convert table to flat list of values

--[[
  Table may have folded tables.

    YES: t = { 'a', b = 'b', { c = 'a' } }
      => { 'a', 'b', 'a' }

  Table should not have cycles.

    NO: t = {} t.t = t

  Only values of table table key-values are processed.

    NO LUCK: t = { [{ 'a' }] = {} }
]]

-- Last mod.: 2024-10-24

local OrderedPairs = request('ordered_pass')

local ToList
ToList =
  function(Node, Result)
    assert_table(Node)

    for Key, Value in OrderedPairs(Node) do
      if is_table(Value) then
        ToList(Value, Result)
      else
        table.insert(Result, Value)
      end
    end
  end

local ToListWrapper =
  function(Node)
    local Result = {}
    ToList(Node, Result)
    return Result
  end

-- Exports:
return ToListWrapper

--[[
  2024-10-20
]]
