--[[
  Encrypt given string with Salsa20. Returns string.

  Call with encrypted string decrypts.

    <plaintext> - string
    <key> - 32-byte string
    <salt> - 8-byte string (session-dependent one-time random)
    <first_block_num> = 1 - integer, internal counter
]]

local handle_plain = request('handle_plain')
local handle_key = request('handle_key')
local handle_salt = request('handle_salt')
local handle_block_num = request('handle_block_num')

local create_block = request('!.bare.crypt.salsa20.create_block')
local generate_shuffle_routine = request('!.bare.crypt.salsa20.generate_shuffle_routine')
local xor_strings = request('!.bare.bin_ops.xor_strings')

-- local print_block = request('print_block')

local C = {0x61707865, 0x3320646E, 0x79622D32, 0x6B206574}

local shuffle_block = generate_shuffle_routine({7, 9, 13, 18}, 10)

local _16_words_fmt = '<' .. (' I4'):rep(16)

return
  function(a_plain, a_key, a_salt, a_first_block_num)
    local plain = handle_plain(a_plain)
    local key = handle_key(a_key)
    local salt = handle_salt(a_salt)
    local block_num = handle_block_num(a_first_block_num)

    local result = {}

    local num_blocks = math.ceil(#plain / 64)
    local base_block = create_block(C, key, salt, block_num)
    for i = 1, num_blocks do
      local result_block = shuffle_block(base_block)
      result[#result + 1] = _16_words_fmt:pack(table.unpack(result_block))
      -- [1]
      if (base_block[9] == 0xFFFFFFFF) then
        base_block[9] = 0
        base_block[10] = base_block[10] + 1
      else
        base_block[9] = base_block[9] + 1
      end
    end
    result = table.concat(result)
    result = xor_strings(result, plain, #plain)

    return result
  end

--[[
  [1]:
    <block[9]> <block[10]> holds 64-bit <block_num> counter.
    We modify them directly to keep some speed. Reliable way is
    increment <block_num> and call "create_block()" again.
]]
