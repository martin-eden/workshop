--[[
  Creates lua function that executes block shuffle.

  I was upset with low performance of my [shuffle_block]
  in comparison with [plc.salsa20].

  I do not like writing code with low entropy and low clarity
  (like "f(1, 5, 9, 13) f(2, 6, 10, 14) ...").

  So I wrote function that generates such code,
  compiles it to function and runs.
]]

-- Last mod.: 2024-11-24

local text_block = new(request('!.mechs.text_block.interface'))

local add_line =
  function(s)
    text_block:request_clean_line()
    text_block:add_curline(s)
  end

local empty_line =
  function()
    text_block:request_empty_line()
  end

local inc_indent =
  function()
    text_block:inc_indent()
  end

local dec_indent =
  function()
    text_block:dec_indent()
  end

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

local get_index =
  function(coord)
    matrix_cursor:wrap_coords(coord)
    return matrix_cursor:get_index(coord)
  end

local generate_initial_assignment =
  function()
    for i = 1, 16 do
      add_line(('local r_%d = block[%d]'):format(i, i))
    end
  end

local emit =
  function(sum_i, cur, prev, prev_prev, shift)
    add_line(
      ('sum_%d = (r_%d + r_%d) & 0xFFFFFFFF'):format(sum_i, prev, prev_prev)
    )
    add_line(
      ('r_%d = r_%d ~ ((sum_%d << %d) | (sum_%d >> %d) & 0xFFFFFFFF)'):
      format(cur, cur, sum_i, shift, sum_i, 32 - shift)
    )
  end

local generate_main_cycle =
  function(shifts, num_dbl_rounds)
    local result = {}
    empty_line()
    add_line('local sum_1, sum_2, sum_3, sum_4')
    add_line(('for i = 1, %d do'):format(num_dbl_rounds))
    inc_indent()

    local cur, prev, prev_prev
    for i = 0, 3 do
      for j = 0, 3 do
        cur = get_index({x = i, y = i + j + 1})
        prev = get_index({x = i, y = i + j})
        prev_prev = get_index({x = i, y = i + j - 1})
        emit(i + 1, cur, prev, prev_prev, shifts[j + 1])
      end
    end
    for i = 0, 3 do
      for j = 0, 3 do
        cur = get_index({y = i, x = i + j + 1})
        prev = get_index({y = i, x = i + j})
        prev_prev = get_index({y = i, x = i + j - 1})
        emit(i + 1, cur, prev, prev_prev, shifts[j + 1])
      end
    end

    dec_indent()
    add_line('end')
  end

local generate_final_assignment =
  function()
    empty_line()
    for i = 1, 16 do
      add_line(
        ('result[%d] = (block[%d] + r_%d) & 0xFFFFFFFF'):format(i, i, i)
      )
    end
    add_line('return result')
  end

return
  function(shifts, num_dbl_rounds)
    text_block:init()
    add_line('local result = {}')
    add_line('return')
    inc_indent()
    add_line('function(block)')
    inc_indent()
    generate_initial_assignment()
    generate_main_cycle(shifts, num_dbl_rounds)
    generate_final_assignment()
    dec_indent()
    add_line('end')
    dec_indent()

    local result = text_block:get_text()
    -- print(result)
    result = load(result)()

    return result
  end

--[[
  2017-08
]]
