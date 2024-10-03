-- Return part of list as separate list

--[[
  Return part of list as separate list

  Range is described by two points.

  Input

    List: table
    StartIndex: int
    StopIndex: int

  Output

    Sublist: table

  Explodes on bad input.
]]
return
  function(List, StartIndex, StopIndex)
    assert_table(List)
    assert_integer(StartIndex)
    assert_integer(StopIndex)

    assert(StartIndex <= StopIndex)

    local Result
    --[[
      I see three possible implementations:

        * Obvious "for" with table.insert()
        * table.unpack() to explode segment to sequence and pack it with
          * "{ }" or
          * table.pack()
        * table.move() to copy segment to standalone table

      I'm using table.move() because I'm not sure Lua can carry long
      sequence from table.unpack().
    ]]
    -- Result = table.pack(table.unpack(List, StartIndex, StopIndex))
    Result = {}
    table.move(List, StartIndex, StopIndex, 1, Result)

    return Result
  end

--[[
  2024-10-03
]]
