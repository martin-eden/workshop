-- Reads strings from standard input. Implements [Input]

-- Contract: Read string from stdin
local Read =
  function(self, NumBytes)
    assert_integer(NumBytes)
    assert(NumBytes >= 0)

    local Data = io.stdin:read(NumBytes)

    -- No end-of-file concept in [Input]
    if is_nil(Data) then
      Data = ''
    end

    local IsComplete = (#Data == NumBytes)

    return Data, IsComplete
  end

-- Exports:
return
  {
    -- Interface
    Read = Read,
  }

--[[
  2024-07-24
  2024-08-05
]]
