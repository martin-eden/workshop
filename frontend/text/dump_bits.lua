--[[
  Get table with list of bytes. Print them as bits.
]]

local to_hex_str =
  function(n)
    assert_integer(n)
    local result = ('%02X'):format(n)
    return result
  end

local from_bcd = request('!.number.from_bcd')

local to_bcd_str =
  function(n)
    local is_ok, result = pcall(from_bcd, n)
    if is_ok then
      result = ('%02d'):format(result)
    else
      result = '??'
    end
    return result
  end

local to_bit_str =
  function(n)
    local bit_map = {[0] = '.', [1] = 'X'}
    assert_integer(n)
    local num_bits = 8
    local bits = {}
    for i = 1, num_bits do
      bits[num_bits - i + 1] = bit_map[(n >> (i - 1)) & 1]
    end
    local result = table.concat(bits, ' ')
    -- result = result:reverse()
    return result
  end

local to_dec_str =
  function(n)
    assert_integer(n)
    return ('%03d'):format(n)
  end

return
  function(t, start_idx)
    local format_str = '%4s | %3s | %3s | %3s | %15s'
    assert_table(t)
    start_idx = start_idx or 1
    local result = {}
    table.insert(
      result,
      format_str:format('Offs', 'Hex', 'BCD', 'Dec', 'Bin')
    )
    table.insert(result, ('-'):rep(#result[#result]))
    for i = start_idx, #t do
      local n = t[i]
      table.insert(
        result,
        format_str:
          format(
            to_hex_str(i),
            to_hex_str(n),
            to_bcd_str(n),
            to_dec_str(n),
            to_bit_str(n)
          )
      )
    end
    table.insert(result, '')
    result = table.concat(result, '\n')
    return result
  end
