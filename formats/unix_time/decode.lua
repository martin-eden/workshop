--[[
  Decode timestamp in Unix format (seconds from epoch) to string
  with ISO 8601 datetime.
]]

return
  function(ts)
    assert_integer(ts)
    local result = os.date('%F %T', ts)
    return result
  end
