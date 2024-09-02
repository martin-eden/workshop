-- Reads strings from base string. Implements [Input]

--[[
  Implementation

    abc
    ^

  Base: "abc"
  ReadPos: 1

  Init(Base)
    Set base string, reset read position

  Reset()
    Reset read position
]]

-- Contract: Read string from base string
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
    if (EndPos > #self.Base) then
      EndPos = #self.Base
    end

    local Data = string.sub(self.Base, StartPos, EndPos)

    local IsComplete = (#Data == NumBytes)

    self.ReadPos = EndPos + 1

    return Data, IsComplete
  end

-- Intestines: Set base string
local Init =
  function(self, NewBase)
    assert_string(NewBase)

    self.Base = NewBase
    self:Reset()
  end

-- Intestines: Reset reading position
local Reset =
  function(self)
    self.ReadPos = 1
  end

-- Exported implementation
return
  {
    -- Interface
    Read = Read,

    -- Intestines
    Base = '',
    ReadPos = 1,

    -- Intestines management
    Init = Init,
    Reset = Reset,
  }

--[[
  2024-07-24
  2024-08-09
]]
