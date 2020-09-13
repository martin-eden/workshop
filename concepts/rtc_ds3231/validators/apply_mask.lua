--[[
  Validate data by applying bit mask to data element with given index.

  This module is part of optional validation. That's why separate
  module for one line.
]]

return
  function(data, idx, mask)
    data[idx] = data[idx] & mask
  end
