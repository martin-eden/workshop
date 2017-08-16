local key_fmt = '<' .. (' I4'):rep(8)
local salt_fmt = '<' .. (' I4'):rep(2)

return
  function(self)
    assert_string(self.key)
    assert(#self.key == 32, 'Key length must be 32 bytes (256 bits).')

    assert_string(self.salt)
    assert(#self.salt == 8, 'Salt (nonce) must be 8-byte string (64 bits).')

    assert_string(self.input)

    self.output = ''

    self.inner_key = {(key_fmt):unpack(self.key)}
    self.inner_key[#self.inner_key] = nil

    self.inner_salt = {(salt_fmt):unpack(self.salt)}
    self.inner_salt[#self.inner_salt] = nil
  end
