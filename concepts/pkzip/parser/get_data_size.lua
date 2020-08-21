--[[
  Get compressed file data size and return it.

  Input is <locator> record.

  No, it's not trivial due PKZIP design decisions.
  Correct compressed data size may be stored in one of 5 (five)
  locations (file_rec, file_rec.extra_data, file_rec.post_rec,
  locator, locator.extra_data).
]]

local locate_zip64_rec = request('locate_zip64_rec')

local FFx4 = 0xFFFFFFFF

return
  function(locator)
    local result = locator.compressed_size
    -- Size too big, so stored in Zip64 record?
    if (result == FFx4) then
      local zip64_rec = locate_zip64_rec(locator)
      assert(zip64_rec)
      result = zip64_rec.compressed_size
    end
    return result
  end
