--[[
  Convert table with list of numbers in Zip64 record to named table.

  Algorithm is following:

    if locator.original_size == 0xFFFFFFFF
      zip64.original_size = zip64[1]
      table.remove(zip64, 1)
    if locator.compressed_size == 0xFFFFFFFF
      zip64.compressed_size = zip64[1]
      table.remove(zip64, 1)
    .. and same for ".file_offset" and "file_disk" fields
]]

local locate_zip64_rec = request('locate_zip64_rec')

local FFx4 = 0xFFFFFFFF
local FFx2 = 0xFFFF

return
  function(locator)
    local zip64 = locate_zip64_rec(locator)
    if (locator.original_size == FFx4) then
      assert(#zip64 >= 1)
      zip64.original_size = zip64[1]
      table.remove(zip64, 1)
    end
    if (locator.compressed_size == FFx4) then
      assert(#zip64 >= 1)
      zip64.compressed_size = zip64[1]
      table.remove(zip64, 1)
    end
    if (locator.file_offset == FFx4) then
      assert(#zip64 >= 1)
      zip64.file_offset = zip64[1]
      table.remove(zip64, 1)
    end
    if (locator.file_disk == FFx2) then
      assert(#zip64 >= 1)
      zip64.file_disk = zip64[1]
      table.remove(zip64, 1)
    end
  end
