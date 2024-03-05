-- Parse string with list of records

--[[
  Input

    string - data

    function - deserializer

      Deserializer. Decompiler. Parser. Anyway, any function that
      gets string and returns something.

      If you just want to split string to list, without chunks processing,
      use "string.split". If you still want to use this function,
      pass "tostring" as deserializer.

    string - separator

      Data items separator. Typically ",". But you can be creative.

  Output

    table

      Sequence of deserializers results.
]]

-- Last mod.: 2024-03-04

local SplitString = request('!.string.split')

return
  function(DataStr, Deserializer, Separator)
    assert_string(DataStr)
    assert_function(Deserializer)
    assert_string(Separator)

    local Results
    do
      Results = {}
      local Chunks = SplitString(DataStr, Separator)
      for _, Chunk in ipairs(Chunks) do
        table.insert(Results, Deserializer(Chunk))
      end
    end
    assert_table(Results)

    return Results
  end

--[[
  2024-03-04
]]
