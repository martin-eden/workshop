-- Assert that string has no entries of given regexp pattern

-- Last mod.: 2024-02-13

local ErrorMsgFmt = [[
String should not have encounters of this pattern.
  string: %q
  pattern: %q
  found at position: %d
]]

return
  function(S, SearhPattern)
    assert_string(S)
    assert_string(SearhPattern)
    local PatternPosition = string.find(S, SearhPattern)
    if PatternPosition then
      local ErrorMsg =
        string.format(ErrorMsgFmt, S, SearhPattern, PatternPosition)
      error(ErrorMsg)
    end
  end
