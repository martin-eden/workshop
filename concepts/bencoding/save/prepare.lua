local is_arrayable = request('!.mechs.array.is_arrayable')
local to_array = request('!.mechs.array.from_table')

local visited

local valid_value_types =
  {
    table = true,
    integer = true,
    string = true,
  }

local prepare
prepare =
  function(t)
    visited[t] = true
    if is_arrayable(t) then
      for k in pairs(t) do
        if not is_integer(k) then
          t[k] = nil
        end
      end
    else
      for k in pairs(t) do
        if not is_string(k) then
          t[k] = nil
        end
      end
    end

    for k, v in pairs(t) do
      local v_type = type(v)
      if (v_type == 'number') then
        v_type = is_integer(v) and 'integer'
      end
      if not valid_value_types[v_type] then
        t[k] = nil
      end
    end

    for k, v in pairs(t) do
      if is_table(v) then
        if visited[v] then
          t[k] = nil
        else
          prepare(v)
        end
      end
    end

    if is_arrayable(t) then
      to_array(t)
    end

    return t
  end

return
  function(t)
    assert_table(t)
    visited = {}
    prepare(t)
  end
