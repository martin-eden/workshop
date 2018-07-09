--[[
  Convert table with list of numbers in zip64 extra record to
  named table.

  Algorithm is following

    if file_rec.original_size == 0xFFFFFFFF
      zip64.original_size = zip64[1]
      zip64.compressed_size = zip64[2]
      zip64[1], zip64[2] = nil, nil
]]

local locate_zip64_rec = request('locate_zip64_rec')

local FFx4 = 0xFFFFFFFF

return
  function(file_rec)
    local zip64 = locate_zip64_rec(file_rec)

    if (file_rec.original_size == FFx4) then
      assert(#zip64 == 2)
      assert(file_rec.compressed_size == FFx4)

      zip64.original_size = zip64[1]
      zip64.compressed_size = zip64[2]
      zip64[1], zip64[2] = nil, nil
    end
  end
