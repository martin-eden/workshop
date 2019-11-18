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
    assert_integer(n)
    local num_bits = 8
    local bits = {}
    for i = 1, num_bits do
      bits[i] = (n >> (i - 1)) & 1
    end
    local result = table.concat(bits)
    result = result:reverse()
    return result
  end

return
  function(t, start_idx)
    assert_table(t)
    start_idx = start_idx or 1
    local result = {}
    table.insert(result, '-offs-  --bin--    -hex- -bcd-  -dec-')
    for i = start_idx, #t do
      local n = t[i]
      table.insert(
        result,
        ('%4s %11s %5s %5s     %03d'):
        format(
          to_hex_str(i),
          to_bit_str(n),
          to_hex_str(n),
          to_bcd_str(n),
          n
        )
      )
    end
    result = table.concat(result, '\n')
    return result
  end
