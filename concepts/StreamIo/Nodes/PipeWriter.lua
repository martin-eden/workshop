-- Writes strings to standard output. Implements [Writer]

-- Contract: Write string
local Write =
  function(self, Data)
    assert_string(Data)

    local IsOk = io.stdout:write(Data)

    if is_nil(IsOk) then
      return 0, false
    end

    return #Data, true
  end

-- Exports:
return
  {
    -- Interface
    Write = Write,
  }

--[[
  2024-07-19
  2024-08-05
]]
