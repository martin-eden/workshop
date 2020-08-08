--[[
  Make sure given bytes have zeroes in specific places.

  Receives report table with invalid byte slots and their masks.
  Masks that byte values to make them valid.
]]

return
  function(data, report)
    for i, rec in ipairs(report) do
      data[rec.idx] = data[rec.idx] & rec.mask
    end
  end
