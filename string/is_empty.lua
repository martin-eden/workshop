-- Return true when the string is empty, false otherwise

-- 2024-02-17

return
  function(s)
    assert_string(s)
    return (s == '')
  end
