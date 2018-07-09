local parsers =
  {
    ['\x01\x00'] =
      {
        type = 'zip64',
        parse = request('extra_data.zip64_values'),
      },
    ['\x0A\x00'] =
      {
        type = 'ntfs',
        parse = request('extra_data.ntfs_tags'),
      },
    ['ux'] =
      {
        type = 'infozip_unix_extra',
        parse = request('extra_data.infozip_unix_extra'),
      },
    ['UT'] =
      {
        type = 'infozip_timestamp',
        parse = request('extra_data.infozip_timestamp'),
      },
    unknown =
      {
        type = 'unknown',
        parse = request('extra_data.unknown'),
      },
  }

return
  function(data)
    local result = {}
    local signature, part_data
    local start_pos = 1
    while (start_pos <= #data) do
      signature, part_data, start_pos = ('< c2 s2'):unpack(data, start_pos)
      local parse_rec = parsers[signature] or parsers.unknown
      local parsed_rec = parse_rec.parse(part_data)
      parsed_rec.meta =
        {
          type = parse_rec.type,
          signature = signature,
        }
      table.insert(result, parsed_rec)
    end

    --[[
      HackIt: Techincally there may be many instances with same
      signature. But in practice all signatures in given extra
      data record are unique.
    ]]

    return result
  end
