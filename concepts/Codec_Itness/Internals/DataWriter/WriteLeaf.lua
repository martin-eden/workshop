-- Serialize string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-26
]]

--[[
  Serialize tree leaf

  Tree leaf is a string. So we are worrying only about quoting syntax
  characters.

  Problem reminder

    Syntax characters

      Framing: ()
      Quoting: []
      Delimiters: " ", "\n"

    What if value is "a b("?

    One-level directed quotes [] are coming to rescue: "[a b(]"!
    Or "a[ b(]" if we want to open and close quote only when we
    absolutely need to.

    What if the value is "[" or "]"?

    Quoting is one-level, first "[" starts quote, first "]" ends
    quote. So "[" is serialized as "[[]" and "]" is serialized as "]".

  Implementation

    State machine.

    State is "Quoted" or "Unquoted".

    "Quoted" is when we emitted opening quote "[". In this state we are
    worrying only about encountering closing quote "]" in data. And
    adding closing quote when data ends.

    "Unquoted" is default state. We're writing characters as-is
    until first syntax character.

    (Except for end-of-quote character. end-of-quote character "]" does
    not require switching to quoting mode.)
]]

local WriteLeaf =
  function(Me, str)
    local quote_open_char = Me.Syntax.quote_open_char
    local quote_close_char = Me.Syntax.quote_close_char
    local IsSyntaxChar_Map = Me.IsSyntaxChar_Map
    local syntax_chars_regexp = Me.syntax_chars_regexp

    -- State: is character inside quotes?
    local in_quotes = false

    -- Encode character
    local encode_char =
      function(char)
        local Result = char

        if
          not in_quotes and
          (
            IsSyntaxChar_Map[char] and
            (char ~= quote_close_char)
          )
        then
          Result = quote_open_char .. char
          in_quotes = true
        end

        if
          in_quotes and
          (char == quote_close_char)
        then
          Result = quote_close_char .. char
          in_quotes = false
        end

        return Result
      end

    -- Quote syntax characters in data
    local encoded_str = string.gsub(str, syntax_chars_regexp, encode_char)

    -- Close opened quote at end of string
    if in_quotes then
      encoded_str = encoded_str .. quote_close_char
      in_quotes = false
    end

    -- Special case: empty string. Serialize to "[]"
    if (str == '') then
      encoded_str = quote_open_char .. quote_close_char
    end

    Me.Output:Write(encoded_str)
  end

-- Export:
return WriteLeaf

--[[
  2024-09-03
  2024-10-20
]]
