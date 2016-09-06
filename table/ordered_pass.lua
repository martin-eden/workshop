local chunk_name = 'ordered_pass'

local extract_keys = request('extract_keys')

local create_sorted_pairs =
  function(t, keys_compare_function)
    assert_table(t)
    assert_function(keys_compare_function)

    local sorted_keys = extract_keys(t)
    table.sort(sorted_keys, keys_compare_function)

    local i = 1
    local sorted_next =
      function(tt, prev_key)
        if sorted_keys[i] then
          i = i + 1
          return sorted_keys[i - 1], tt[sorted_keys[i - 1]]
        else
          sorted_keys = nil
        end
      end
    return sorted_next, t
  end

tribute(chunk_name, create_sorted_pairs)
