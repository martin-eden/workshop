-- Reader interface

--[[
  Exports

    {
      Read() - read function
    }
]]

--[[
  Read given amount of bytes to string

  Input:
    NumBytes (uint) >= 0

  Output:
    Data (string)
    IsComplete (bool)

  Details

    If we can't read <NumBytes> bytes we read what we can and set
    <IsComplete> to FALSE. Typical case is empty string for end-of-file
    state.

    Reading zero bytes is neutral operation which can be used to detect
    problems through <IsComplete> flag.
]]
local Read =
  function(self, NumBytes)
    assert_integer(NumBytes)
    assert(NumBytes >= 0)

    local ResultStr = ''
    local IsComplete = false

    return ResultStr, IsComplete
  end

-- Exports:
return
  {
    Read = Read,
  }

--[[
  2024-07-19
  2024-07-24
]]
