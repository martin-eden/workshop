-- Quote string in long quotes

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

--[==[
  Long quotes

  Long quotes are directed multi-character quotes in Lua.

  String data inside them is mostly not processed. So no need to worry
  about quoting some "special" characters.

  However if first character after quote is newline -- it's dropped.
  That's language curtsy for readability. Nice but still you can't
  indent data. And tail newline is not dropped.

  So that's all the same:

    > s = [[
    Hello!]]
    > s = [[Hello!]]
    > s = [=[Hello!]=]
]==]

local str_find = string.find
local str_sub = string.sub

local quote_long =
  function(str)
    local opening_bracket = '['
    local closing_bracket = ']'
    local filler_char = '='
    local newline_char = '\010'
    local return_char = '\013'

    -- (1)
    str = str .. closing_bracket

    local filler_chunk = ''
    do
      while true do
        local postfix =
          closing_bracket .. filler_chunk .. closing_bracket

        if not str_find(str, postfix) then break end

        filler_chunk = filler_chunk .. filler_char
      end
    end

    local prefix = opening_bracket .. filler_chunk .. opening_bracket

    -- (2)
    local first_char = str_sub(str, 1, 1)
    local first_char_is_newline =
      (first_char == newline_char) or (first_char == return_char)

    if first_char_is_newline then
      prefix = prefix .. first_char
    end

    -- (3)
    local has_newlines = not is_nil(str_find(str, newline_char))
    if has_newlines and not first_char_is_newline then
      prefix = prefix .. newline_char
    end

    return prefix .. str .. filler_chunk .. closing_bracket
  end

-- Export:
return quote_long

--[===[
  [1] Quoted result string will have following structure:

    "[" "="^N "[" ["\n"] s "]" "="^N "]"

    We may safely concatenate "]" to <s> before determining <N>.
    This is done to avoid following cases:

      s     | unpatched   |  patched
      ------+-------------+--------------
      "]"   | "[[]]]"     | "[=[]]=]"
      "]]=" | "[=[]]=]=]" | "[==[]]=]==]"

    Case pointed by Roberto Ierusalimschy 2018-12-14 in Lua Mail
    List.

  [2] Heading newline dropped from long string quote. So we need
    duplicate it to preserve second copy. Before it all variants
    of newlines are converted to 0x0A.

    Tricky case here is if we have 0x0D we cant add 0x0A or it still
    be interpreted as one newline.

    Nice workaround is duplicate first byte of newline:

      0D    | 0D 0D    | \
      0A    | 0A 0A    |   still two line
      0D 0A | 0D 0D 0A |   delimiters!
      0A 0D | 0A 0A 0D | /

    Case and solution pointed by Andrew Gierth 2018-12-15 in Lua
    Mail List.

  [3]
    If string is multiline like "Hey\n  buddy!\n" then we want to
    represent it as
      > [[
      > Hey
      >   buddy!
      > ]]

    Not as
      > [[Hey
      >   buddy!
      > ]]

    For the sake of readability.

    Here we should be careful not to collide with possible newline
    from step 2.
  ]=]

]===]

--[[
  2017 #
  2018 #
  2024 #
  2026-07-11
]]
