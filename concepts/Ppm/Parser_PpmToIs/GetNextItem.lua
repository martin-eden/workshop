-- Get next item

-- Last mod.: 2024-11-04

local IsSpace =
  function(Char)
    return
      (Char == ' ') or
      (Char == '\t')
  end

local IsNewline =
  function(Char)
    return
      (Char == '\n') or
      (Char == '\r')
  end

local IsDelimiter =
  function(Char)
    return IsSpace(Char) or IsNewline(Char)
  end

-- Read until end of stream or until end of line
local SkipLine =
  function(self)
    while self:GetNextCharacter() do
      if IsNewline(self.NextCharacter) then
        break
      end
    end
  end

--[[
  Get next item

  Skips line comments.

    > P3
    > 1920 1080 # Width Height
    > 255

  Items are "P3", "1920", "1080", "255"
]]
local GetNextItem =
  function(self)
    local Char

    ::Redo::

    -- Space eating cycle
    while self:GetNextCharacter() do
      Char = self.NextCharacter

      if not IsDelimiter(Char) then
        break
      end

      PrevChar = Char
    end

    -- Check for line comment
    do
      local CommentChar = '#'

      if (Char == CommentChar) then
        -- Skip until end of line. Damned comment
        SkipLine(self)
        goto Redo
      end
    end

    -- Catenate characters to <Term>
    local Term = Char

    while self:GetNextCharacter() do
      Char = self.NextCharacter

      if IsDelimiter(Char) then
        break
      end

      Term = Term .. Char
    end

    return Term
  end

-- Exports:
return GetNextItem

--[[
  2024-11-02
]]
