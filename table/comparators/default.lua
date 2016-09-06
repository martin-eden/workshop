local chunk_name = 'default'

local val_rank =
  {
    number = 0,
    string = 1,
    other = 3,
  }

local get_rank =
  function(val)
    return val_rank[type(val)] or val_rank.other
  end

local comparable_types =
  {
    number = true,
    string = true,
  }

local compare_function =
  function(a, b)
    local result
    local a_key, b_key = a.key, b.key
    local rank_a, rank_b = get_rank(a_key), get_rank(b_key)
    if (rank_a ~= rank_b) then
      result = (rank_a < rank_b)
    else
      if comparable_types[type(a_key)] and comparable_types[type(b_key)] then
        result = (a_key < b_key)
      else
        result = (tostring(a_key) < tostring(b_key))
      end
    end
    return result
  end

tribute(chunk_name, compare_function)
