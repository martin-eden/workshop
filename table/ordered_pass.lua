require('#base')

local chunk_name = 'table.ordered_pass'

local create_keys_array =
  function(t)
    local result = {}
    for k in pairs(t) do
      result[#result + 1] = k
    end
    return result
  end

local val_rank =
  {
    number = 0,
    string = 1,
    other = 3,
  }

local get_val_rank =
  function(val)
    return val_rank[type(val)] or val_rank.other
  end

local comparable_type =
  {
    number = true,
    string = true,
  }

local compare_function =
  function(a, b)
    local rank_a, rank_b = get_val_rank(a), get_val_rank(b)
    local type_a, type_b = type(a), type(b)
    if (rank_a ~= rank_b) then
      return (rank_a < rank_b)
    elseif comparable_type[type_a] and comparable_type[type_b] then
      return (a < b)
    else
      return (tostring(a) < tostring(b))
    end
  end

local create_sorted_pairs =
  function(t)
    local sorted_keys = create_keys_array(t)
    table.sort(sorted_keys, compare_function)
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
