local unpack_format_string = '<' .. ('I4'):rep(16)

return
  function(s, read_pos)
    local result = {unpack_format_string:unpack(s, read_pos)}
    result[#result] = nil
    return result
  end
