-- ASCII characters table

--[[
  Author: Martin Eden
  Last mod.: 2026-08-01
]]

local Codes =
  {
    -- Whitespace / control
    tab = 9,                -- TAB
    newline = 10,           -- LF
    carriage_return = 13,   -- CR
    space = 32,             -- SPACE
    delete = 127,           -- DEL

    -- Arithmetic operators
    plus = 43,              -- +
    minus = 45,             -- -
    asterisk = 42,          -- *
    slash = 47,             -- /

    -- Comparison / assignment
    less_than = 60,         -- <
    equals = 61,            -- =
    greater_than = 62,      -- >

    -- Punctuation
    dot = 46,               -- .
    comma = 44,             -- ,
    colon = 58,             -- :
    semicolon = 59,         -- ;

    -- Quoting / escaping
    single_quote = 39,      -- '
    double_quote = 34,      -- "
    backtick = 96,          -- `
    backslash = 92,         -- \

    -- Symbols
    number_sign = 35,       -- #
    question_mark = 63,     -- ?
    bang = 33,              -- !
    percent = 37,           -- %
    ampersand = 38,         -- &
    dollar_sign = 36,       -- $
    at_sign = 64,           -- @
    caret = 94,             -- ^
    underscore = 95,        -- _
    pipe = 124,             -- |
    tilde = 126,            -- ~

    -- Paired brackets
    opening_paren = 40,     -- (
    closing_paren = 41,     -- )
    opening_bracket = 91,   -- [
    closing_bracket = 93,   -- ]
    opening_brace = 123,    -- {
    closing_brace = 125,    -- }
  }

local Chars
do
  Chars = { }
  local str_char = string.char
  for name, code in pairs(Codes) do
    Chars[name] = str_char(code)
  end
end

local is_control_code
do
  local assert_byte = request('!.number.assert_byte')

  is_control_code =
    function(code)
      assert_byte(code)

      return (code <= 31) or (code == 127)
    end
end

local Ascii =
  {
    Chars = Chars,
    Codes = Codes,
    is_control_code = is_control_code,
  }

-- Export:
return Ascii

--[[
  2026-08-01
]]
