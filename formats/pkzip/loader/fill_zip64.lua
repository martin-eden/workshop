local max_ui4 = 0xFFFFFFFF
local max_ui2 = 0xFFFF

return
  function(self, rec)
    -- Currently <.zip64> is just sequence of uint64. Name them:
    local zip64 = rec.additional_data.zip64
    local idx_to_name = 1
    if (rec.original_size == max_ui4) and zip64[idx_to_name] then
      zip64.original_size = zip64[idx_to_name]
      zip64[idx_to_name] = nil
      idx_to_name = idx_to_name + 1
    end
    if (rec.compressed_size == max_ui4) and zip64[idx_to_name] then
      zip64.compressed_size = zip64[idx_to_name]
      zip64[idx_to_name] = nil
      idx_to_name = idx_to_name + 1
    end
    if (rec.file_offset == max_ui4) and zip64[idx_to_name] then
      zip64.file_offset = zip64[idx_to_name]
      zip64[idx_to_name] = nil
      idx_to_name = idx_to_name + 1
    end
    if (rec.file_disk == max_ui2) and zip64[idx_to_name] then
      zip64.file_disk = zip64[idx_to_name]
      zip64[idx_to_name] = nil
      idx_to_name = idx_to_name + 1
    end
  end
