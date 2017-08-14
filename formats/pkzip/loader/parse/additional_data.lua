local format = '< c2 s2'

return
  function(self, data)
    assert(data ~= '')

    local result = {}
    local id, part_data
    local start_pos = 1
    while (start_pos <= #data) do
      id, part_data, start_pos = format:unpack(data, start_pos)
      result[#result + 1] = {id = id, data = part_data}
    end

    --[[
      HackIt: for ease of use and typical case we assume that
      there is no more than one instance of given <.id>.
      Techincally there may be many instances with same <.id>.
      But we have no idea how to handle this case anyway.
    ]]

    for i = #result, 1, -1 do
      local rec = result[i]
      if (rec.id == self.signatures.additional_data.ntfs) then
        result.ntfs = self:parse_ntfs_add_data(rec.data)
        result.ntfs.id = rec.id
        table.remove(result, i)
      elseif (rec.id == self.signatures.additional_data.zip64) then
        result.zip64 = self:parse_zip64_add_data(rec.data)
        result.zip64.id = rec.id
        table.remove(result, i)
      end
    end

    return result
  end
