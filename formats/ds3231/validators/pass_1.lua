--[[
  Make sure we return sequence of bytes.

  Receives report table with invalid byte slots.
  Sets invalid data slots to random byte values.
]]

return
  function(data, report)
    for i, rec in ipairs(report) do
      data[rec.idx] = math.random(0, 0xFF)
    end
  end
