local eight_words_fmt = '<' .. (' I4'):rep(8)

return
  function(a_key)
    local result
    assert_string(a_key)
    assert(#a_key == 32, 'Key length must be 32 bytes (256 bits).')
    result = {(eight_words_fmt):unpack(a_key)}
    result[#result] = nil
    return result
  end
