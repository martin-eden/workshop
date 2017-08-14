return
  function(self, data)
    local result = {}
    local reserved, start_pos = ('< c4'):unpack(data)
    result.reserved = reserved

    --[[
      HackIt: Same thoughts as for [parse_additional_data] should
      be stated here. Technically <data> string may have several
      chunks with same tag. But in wild (in 2017) only one possible
      tag and only one chunk. So data just pushed up to the parent
      level.
    ]]
    local tag, chunk
    while (start_pos <= #data) do
      tag, chunk, start_pos = ('< c2 s2'):unpack(data, start_pos)
      if (tag == '\x01\x00') then
        result.mtimes = self:parse_ntfs_mtimes(chunk)
        result.mtimes.tag = tag
      else
        result[#result + 1] = {tag = tag, chunk = chunk}
      end
    end
    return result
  end
