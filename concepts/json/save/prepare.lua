-- Changes given table (no matter how bad it is) for JSON serialization.

-- Counterpart of verify().

local is_arrayable = request('!.mechs.array.is_arrayable')
local to_array = request('!.mechs.array.from_table')

local visited

local valid_value_types =
  {
    table = true,
    number = true,
    string = true,
    boolean = true,
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
      if not valid_value_types[type(v)] then
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

    if is_arrayable(t) and next(t) then --(1)
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

--[[
  [1]
    Corner case: empty table field value {} may be presented both as
    empty object {} or empty array []. Actual format depends of
    [mechs.array.is_array] implementation. Currently it saves empty
    tables as object.
]]
