-- Itness format parsing

-- Last mod.: 2024-10-21

-- Add to container non-nil value
local AddTo =
  function(Container, Value)
    if not is_nil(Value) then
      table.insert(Container, Value)
    end
  end

--[[
  Parse string to table

  Input
    self.Input [Reader]

  Output
    table
]]
local Parse
Parse =
  function(self)
    -- Syntels shortcuts:
    local OpeningGroup = self.Syntax.ListOpening
    local ClosingGroup = self.Syntax.ListClosing
    local OpeningQuote = self.Syntax.QuoteOpening
    local ClosingQuote = self.Syntax.QuoteClosing
    local Space = self.Syntax.Delimiters.Space
    local Newline = self.Syntax.Delimiters.Newline

    local Result = {}

    local Term = nil

    local InQuotes = false

    while true do
      local Char, IsOk = self.Input:Read(1)

      if not IsOk then
        break
      end

      if (Char == OpeningGroup) and not InQuotes then
        AddTo(Result, Term)
        Term = nil
        AddTo(Result, Parse(self))
      elseif (Char == ClosingGroup) and not InQuotes then
        AddTo(Result, Term)
        return Result
      elseif (Char == OpeningQuote) and not InQuotes then
        InQuotes = true
        --[[
          We want "term" stop being nil when we encountered quote.

          That's for empty string which is encoded as [].
        ]]
        Term = Term or ''
      elseif (Char == ClosingQuote) and InQuotes then
        InQuotes = false
      elseif ((Char == Space) or (Char == Newline)) and not InQuotes then
        AddTo(Result, Term)
        Term = nil
      else
        Term = Term or ''
        Term = Term .. Char
      end
    end

    AddTo(Result, Term)

    return Result
  end

-- Export:
return Parse

--[[
  2024-07-19
  2024-08-04
  2024-10-20
  2024-10-21
]]
