return
  function(s)
    assert_string(s)

    -- see (1)
    s = s .. ']'

    local min_needed_quotes = 0
    local eq_chunk, postfix
    while true do
      eq_chunk = ('='):rep(min_needed_quotes)
      postfix = ']' .. eq_chunk .. ']'
      if not s:find(postfix, 1, true) then
        break
      end
      min_needed_quotes = min_needed_quotes + 1
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
  [1] Quoted result string will consist of

    "[" "="^N "[" s "]" "="^N "]"
              ^^^   ~~~

    We may safely concatenate parts "^" and "~" to <s> before
    determining <N>.

    We add part "~" to avoid following cases

      s     | unpatched   |  patched
      ------+-------------+--------------
      "]"   | "[[]]]"     | "[=[]]=]"
      "]]=" | "[=[]]=]=]" | "[==[]]=]==]"

    Case pointed by Roberto Ierusalimschy 2018-12-14 in Lua Mail
    List.
]===]
