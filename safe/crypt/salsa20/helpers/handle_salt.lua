local two_words_fmt = '<' .. (' I4'):rep(2)

return
  function(a_salt)
    local result
    assert_string(a_salt)
    assert(#a_salt == 8, 'Salt (nonce) must be 8-byte string (64 bits).')
    result = {(two_words_fmt):unpack(a_salt)}
    result[#result] = nil
    return result
  end
