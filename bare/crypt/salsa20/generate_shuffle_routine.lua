--[[
  Creates lua function that executes block shuffle.

  I was upset with low performance of my [shuffle_block] in comparision
  with [plc.salsa20].

  I do not like code with low entropy (like "f(1, 5, 9, 13) f(2, 6,
  10, 14) ...") and do not like to reduce clarity for specific
  performance.

  So I've created experimental routine that creates string that is
  lua code that is compiled to function which is returned.
]]

local generate_initial_assignment =
  function()
    local result = {''}
    for i = 1, 16 do
      result[#result + 1] =
        ('    local r_%d = block[%d]'):
        format(i, i, i)
    end
    result = table.concat(result, '\n')
    return result
  end

local emit =
  function(sum_i, cur, prev, prev_prev, shift)
    return
      ('      sum_%d = (r_%d + r_%d) & 0xFFFFFFFF\n'):format(sum_i, prev, prev_prev) ..
      ('      r_%d = r_%d ~ ((sum_%d << %d) | (sum_%d >> %d) & 0xFFFFFFFF)'):
      format(cur, cur, sum_i, shift, sum_i, 32 - shift)
  end

local coord_to_idx =
  function(row, col)
    while (row < 0) do
      row = row + 4
    end
    row = row % 4
    while (col < 0) do
      col = col + 4
    end
    col = col % 4
    local result = row * 4 + col
    result = result + 1
    return result
  end

local generate_main_cycle =
  function(shifts, num_dbl_rounds)
    local result = {''}

    result[#result + 1] = '    local sum_1, sum_2, sum_3, sum_4'
    result[#result + 1] = ('    for i = 1, %d do'):format(num_dbl_rounds)

    for i = 0, 3 do
      for j = 0, 3 do
        local cur = coord_to_idx(j + i + 1, i)
        local prev = coord_to_idx(j + i, i)
        local prev_prev = coord_to_idx(j + i - 1, i)
        result[#result + 1] = emit(i + 1, cur, prev, prev_prev, shifts[j + 1])
      end
    end
    for i = 0, 3 do
      for j = 0, 3 do
        local cur = coord_to_idx(i, i + j + 1)
        local prev = coord_to_idx(i, i + j)
        local prev_prev = coord_to_idx(i, i + j - 1)
        result[#result + 1] = emit(i + 1, cur, prev, prev_prev, shifts[j + 1])
      end
    end

    result[#result + 1] = '    end'

    result = table.concat(result, '\n')

    return result
  end

local generate_final_assignment =
  function()
    local result = {''}
    for i = 1, 16 do
      result[#result + 1] =
        ('    result[%d] = (block[%d] + r_%d) & 0xFFFFFFFF'):
        format(i, i, i)
    end
    result[#result + 1] = '    return result'
    result = table.concat(result, '\n')
    return result
  end

return
  function(shifts, num_dbl_rounds)
    assert_table(shifts)
    assert_integer(num_dbl_rounds)

    local result =
      ([[
local result = {}
return
  function(block)
    %s
    %s
    %s
  end
]]    ):
      format(
        generate_initial_assignment(),
        generate_main_cycle(shifts, num_dbl_rounds),
        generate_final_assignment()
      )

    -- print(result)
    result = load(result)()

    return result
  end
