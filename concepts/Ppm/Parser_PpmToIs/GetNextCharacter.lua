-- Get next character

-- Last mod.: 2024-11-02

--[[
  Get next character from input stream.

  We store character in <.NextCharacter>.

  On end of stream:

    <.NextCharacter> = nil
    return false

  We can't move stream back. So parsers should call this method
  only when they are done with current <.NextCharacter>.
]]
local GetNextCharacter =
  function(self)
    local Char, IsOkay = self.Input:Read(1)

    if not IsOkay then
      self.NextCharacter = nil

      return false
    end

    self.NextCharacter = Char

    return true
  end

-- Exports:
return GetNextCharacter

--[[
  2024-11-02
]]
