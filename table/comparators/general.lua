local chunk_name = 'general'

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
    local rank_a, rank_b = get_rank(a), get_rank(b)
    if (rank_a ~= rank_b) then
      result = (rank_a < rank_b)
    else
      if comparable_types[type(a)] and comparable_types[type(b)] then
        result = (a < b)
      else
        result = (tostring(a) < tostring(b))
      end
    end
    return result
  end

tribute(chunk_name, compare_function)
