local format = '< c2 s2'

return
  function(self, data)
    assert(data ~= '')

    local id_parsers =
      {
        {
          signature = self.signatures.additional_data.ntfs,
          hive = 'ntfs',
          parser = self.parse_ntfs_add_data,
        },
        {
          signature = self.signatures.additional_data.zip64,
          hive = 'zip64',
          parser = self.parse_zip64_add_data,
        },
        {
          signature = self.signatures.additional_data.infozip_unix_extra,
          hive = 'infozip_unix_extra',
          parser = self.parse_infozip_unix_extra,
        },
        {
          signature = self.signatures.additional_data.infozip_timestamp,
          hive = 'infozip_timestamp',
          parser = self.parse_infozip_timestamp,
        },
      }

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
      for j = 1, #id_parsers do
        local parser_rec = id_parsers[j]
        if (rec.id == parser_rec.signature) then
          result[parser_rec.hive] = parser_rec.parser(self, rec.data)
          result[parser_rec.hive].id = rec.id
          table.remove(result, i)
        end
      end
    end

    return result
  end
