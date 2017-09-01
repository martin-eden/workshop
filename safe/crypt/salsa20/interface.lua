--[[
  Simple interface for Salsa20.

  Only base functionality. For advanced versions use routines from
  "bare.".

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
