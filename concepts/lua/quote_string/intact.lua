-- Quote string in long quotes

-- Last mod.: 2024-11-19

--[==[
  Long quotes

  Long quotes is multi-character quotes in Lua. String data inside them
  are not processed. So no need to worry about quoting some "special"
  characters.

  That's all the same:

    > s = [[
    Hello!]]
    > s = [[Hello!]]
    > s = [=[Hello!]=]
]==]

local has_newlines = request('!.string.content_attributes').has_newlines

return
  function(s)
    assert_string(s)

    -- (1)
    s = s .. ']'

    local eq_chunk = ''
    local postfix
    while true do
      postfix = ']' .. eq_chunk .. ']'
      if not s:find(postfix, 1, true) then
        break
      end
      eq_chunk = eq_chunk .. '='
    end

    local prefix = '[' .. eq_chunk .. '['

    -- (2)
    local first_char = s:sub(1, 1)
    if
      (first_char == '\x0D') or
      (first_char == '\x0A')
    then
      prefix = prefix .. first_char
    end

    -- (3)
    if has_newlines(s) then
      prefix = prefix .. '\x0A'
    end

    return prefix .. s .. eq_chunk .. ']'
  end

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
  ]=]

]===]

--[[
  2017-03
  2018-12
  2024-11
]]
