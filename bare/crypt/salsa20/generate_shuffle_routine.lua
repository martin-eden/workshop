--[[
  Creates lua function that executes block shuffle.

  I was upset with low performance of my [shuffle_block] in comparision
  with [plc.salsa20].

  I do not like writing code with low entropy and low clarity
  (like "f(1, 5, 9, 13) f(2, 6, 10, 14) ..."). So I wrote
  function that generates such code, compiles it to function
  and return.
]]

local matrix_cursor =
  new(
    request('!.mechs.matrix_coords.interface'),
    {
      num_columns = 4,
      num_rows = 4,
      index_base = 1,
      rows_base = 0,
      columns_base = 0,
    }
  )

local coord_to_idx =
  function(coord)
    matrix_cursor:wrap_coords(coord)
    return matrix_cursor:get_index(coord)
  end

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

local generate_main_cycle =
  function(shifts, num_dbl_rounds)
    local result = {''}

    result[#result + 1] = '    local sum_1, sum_2, sum_3, sum_4'
    result[#result + 1] = ('    for i = 1, %d do'):format(num_dbl_rounds)

    local cur, prev, prev_prev
    for i = 0, 3 do
      for j = 0, 3 do
        cur = coord_to_idx({x = i, y = i + j + 1})
        prev = coord_to_idx({x = i, y = i + j})
        prev_prev = coord_to_idx({x = i, y = i + j - 1})
        result[#result + 1] = emit(i + 1, cur, prev, prev_prev, shifts[j + 1])
      end
    end
    for i = 0, 3 do
      for j = 0, 3 do
        cur = coord_to_idx({y = i, x = i + j + 1})
        prev = coord_to_idx({y = i, x = i + j})
        prev_prev = coord_to_idx({y = i, x = i + j - 1})
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
