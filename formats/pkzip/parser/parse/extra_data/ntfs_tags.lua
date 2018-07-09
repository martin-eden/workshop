local parse_ntfs_mtimes = request('ntfs_mtimes')

return
  function(data)
    local result = {}
    local reserved, start_pos = ('< c4'):unpack(data)
    result.reserved = reserved

    --[[
      HackIt: Same thoughts as for [parse.extra_data] should be
      stated here. Technically <data> string may have several chunks
      with same tag. But in a sample files (in 2017) I saw only one
      tag (0x0001) and only one chunk. For this tag parsed data is
      placed at the root level of <result>.
    ]]
    local tag, chunk
    while (start_pos <= #data) do
      tag, chunk, start_pos = ('< c2 s2'):unpack(data, start_pos)
      if (tag == '\x01\x00') then
        result.mtimes = parse_ntfs_mtimes(chunk)
        result.mtimes.tag = tag
      else
        result[#result + 1] = {tag = tag, chunk = chunk}
      end
    end
    return result
  end
