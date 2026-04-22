-- Parse string with list of records

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local SplitString = request('!.string.split')

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
local process_list =
  function(DataStr, Deserializer, Separator)
    assert_string(DataStr)
    assert_function(Deserializer)
    assert_string(Separator)

    local Results
    do
      Results = {}
      DataStr = DataStr .. Separator
      local Chunks = SplitString(DataStr, Separator)
      for _, Chunk in ipairs(Chunks) do
        table.insert(Results, Deserializer(Chunk))
      end
    end
    assert_table(Results)

    return Results
  end

-- Export:
return process_list

--[[
  2024-03-04
]]
