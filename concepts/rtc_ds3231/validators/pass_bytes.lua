--[[
  Change specific index in table to byte value.

  Receives source data table, and index of wrong slot.
  Sets invalid data slot to random byte values.
]]

return
  function(data, idx)
    data[idx] = math.random(0, 0xFF)
  end
