local directory_end_sign = request('^.directory_end_sign')

return
  function(in_stream)
    local max_chunk_size = 64 * 1024 + 20 --possible 64KiB comment +20 bytes overhead
    in_stream:set_position(in_stream:get_length() - max_chunk_size + 1)
    if in_stream:match_regexp(directory_end_sign) then
      in_stream:set_relative_position(-#directory_end_sign)
      return true
    end
  end
