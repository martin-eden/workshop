return
  function(stream, mark_rec)
    assert_table(mark_rec)
    assert_string(mark_rec.type)
    assert(mark_rec.type == 'BS_steel_mark')

    local mark = stream:get_segment(mark.start, mark_rec.len)
    assert_string(mark)
    assert(#mark == 6)
    local result = {}

    local category = mark:sub(1, 1)
    local category_name
    local some_contents
    if (category == '0') or (category == '1') then
      category_name = 'plain carbon'
      some_contents ('Manganese content ppm: %s'):format(mark:sub(2, 3))
    elseif (category == '2') then
      category_name = 'free cutting'
      some_contents ('Sulphur content ppm: %s'):format(mark:sub(2, 3))
    elseif (category == '3') or (category == '4') then
      category_name = 'stainless and valve'
    else
      category_name = 'other alloy'
    end
    result[#result + 1] = ('Category: %s'):format(category_name)
    result[#result + 1] = some_contents

    local prop_type = mark:sub(4, 4)
    local prop_name
    if (prop_type == 'A') then
      prop_name = 'chemistry'
    elseif (prop_type == 'H') then
      prop_name = 'hardening'
    elseif (prop_type == 'M') then
      prop_name = 'mechanical'
    elseif (prop_type == 'S') then
      prop_name = 'stainless or heat-resisitant'
    else
      prop_name = '? unknown'
    end
    result[#result + 1] = ('Properties: %s'):format(prop_name)

    local carbon = mark:sub(5, 6)
    result[#result + 1] = ('Carbon ppm (99 - overflow): %s'):format(carbon)

    result = table.concat(result, '\n')
    return result
  end
