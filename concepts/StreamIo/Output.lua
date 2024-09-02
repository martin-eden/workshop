-- Writer interface

--[[
  Exports:

    {
      Write() - write function
    }
]]

--[[
  Write string

  Input:
    Data (string)

  Output:
    NumBytesWritten (uint)
    IsCompleted (bool)

  Details

    Writing empty string is neutral operation which can be used to
    detect problems by examining <IsCompleted> flag.
]]
local Write =
  function(self, Data)
    assert_string(Data)

    local NumBytesWritten = 0
    local IsCompleted = false

    return NumBytesWritten, IsCompleted
  end

-- Exports:
return
  {
    Write = Write,
  }

--[[
  2024-07-19
  2024-07-24
]]
