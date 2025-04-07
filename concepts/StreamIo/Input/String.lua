-- [Input] stream interface for string

-- Last mod.: 2025-04-07

--[[
  Read bytes from host string

  Contract method.
]]
local Read =
  function(self, NumBytes)
    assert_integer(NumBytes)
    assert(NumBytes >= 0)

    -- Shortcut
    if (NumBytes == 0) then
      return '', true
    end

    local StartPos = self.ReadPos
    local EndPos = StartPos + NumBytes - 1

    if (EndPos > #self.String) then
      EndPos = #self.String
    end

    local ResultStr = string.sub(self.String, StartPos, EndPos)

    local IsComplete = (#ResultStr == NumBytes)

    self.ReadPos = EndPos + 1

    return ResultStr, IsComplete
  end

-- Exported implementation
return
  {
    -- [Interface]
    String = '',
    Read = Read,

    -- [Internals]
    ReadPos = 1,
  }

--[[
  2024-07-24
  2024-08-09
  2025-04-07
]]
