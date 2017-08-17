--[[
  Returns XOR of given strings as string.

    <len> - shorter string length
]]

return
  function(s1, s2, len)
    local last_chunk_len = len % 4
    local num_full_chunks = len // 4
    local start_pos = 1
    local s1_int, s2_int, result_int
    local result = {}

    for i = 1, num_full_chunks do
      s1_int = ('<I4'):unpack(s1, start_pos)
      s2_int = ('<I4'):unpack(s2, start_pos)
      result_int = s1_int ~ s2_int
      result[#result + 1] = ('<I4'):pack(result_int)
      start_pos = start_pos + 4
    end

    for i = 1, last_chunk_len do
      s1_int = ('<I1'):unpack(s1, start_pos)
      s2_int = ('<I1'):unpack(s2, start_pos)
      result_int = s1_int ~ s2_int
      result[#result + 1] = ('<I1'):pack(result_int)
      start_pos = start_pos + 1
    end

    result = table.concat(result)

    return result
  end
