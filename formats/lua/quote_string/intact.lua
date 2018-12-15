return
  function(s)
    assert_string(s)

    -- see (1)
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

    -- Handling special case: heading newline dropped in long strings.
    if
      (s:sub(1, 2) == '\x0d\x0a') or
      (s:sub(1, 1) == '\x0a')
    then
      prefix = prefix .. '\n'
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
]===]
