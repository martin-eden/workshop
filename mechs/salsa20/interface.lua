--[[
  Simple interface for Salsa20.

  <key> - 32-byte string
  <salt> - 8-byte string (session-dependent one-time random)
]]

return
  {
    key = '',
    salt = '',
    block_num = 1,
    encrypt = request('process'),
    decrypt = request('process'),
  }
