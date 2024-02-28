-- Assert that string has no newlines

-- Last mod.: 2024-02-13

local SearhPattern = '[\n\r]'

return
  function(s)
    assert_string(s)
    if s:find(SearhPattern) then
      local ErrorMsg =
        ('Given string should not have newlines. Got %q.'):
        format(s)

      error(ErrorMsg)
    end
  end
