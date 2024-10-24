-- Serialize string

--[=[
  Serialize tree leaf

  Tree leaf is a string. So we are worrying only about quoting syntax
  characters.

  Problem reminder

    Terminal value is string. Container (aka list aka sequence) is
    encoded like "(" .. ")". And items delimiter is stackable " "'s
    or "\n"'s.

    What if value is "a b("?

    One-level directed quotes [] are coming to rescue: "[a b(]".
    Or "a[ b(]" if you want to open and close quote only when you
    absolutely need to.

    What if value has "[" or "]"?

    Quoting is one-level, first "[" starts quote, first "]" ends
    quote. So "[" is serialized as "[[]" and "]" is serialized
    as "]". And " ]" is serialized as "[ ]]".

  Implementation

    State machine.

    State is "Quoted" or "Unquoted".

    "Quoted" when we emitted opening quote "[". So in this state we are
    worrying only about encountering closing quote "]" in data. And
    adding closing quote when data ends.

    "Unquoted" is default state. We're writing characters as-is
    until first syntax character.

    Syntax characters

      Framing: ()
      Quoting: []
      Delimiters: " ", "\n"
]=]

local WriteLeaf =
  function(self, Data)
    assert_string(Data)

    -- Shortcuts:
    local IsSyntaxChar = self.IsSyntaxChar
    local OpeningQuote = self.SyntaxChars.QuoteOpening
    local ClosingQuote = self.SyntaxChars.QuoteClosing
    local SyntaxCharsRegexp = self.SyntaxCharsRegexp

    do
      -- State: is character inside quotes?
      local InQuotes = false

      -- Encode character
      local SerializeChar =
        function(Char)
          local Result = Char

          if
            not InQuotes and
            (
              IsSyntaxChar[Char] and
              (Char ~= ClosingQuote)
            )
          then
            Result = OpeningQuote .. Char
            InQuotes = true
          end

          if
            InQuotes and
            (Char == ClosingQuote)
          then
            Result = ClosingQuote .. Char
            InQuotes = false
          end

          return Result
        end

      -- Quote syntax characters in data
      EncodedData = string.gsub(Data, SyntaxCharsRegexp, SerializeChar)

      if InQuotes then
        -- Close opened quote at end of value
        EncodedData = EncodedData .. ClosingQuote
        InQuotes = false
      end

      if (Data == '') then
        --[[
          Special case: empty string

          By default it's serialized to an empty string and lost.
          We are serializing it to [].
        ]]
        EncodedData = OpeningQuote .. ClosingQuote
      end
    end

    self.Output:Write(EncodedData)
  end

-- Exports:
return WriteLeaf

--[[
  2024-09-03
  2024-10-20
]]
