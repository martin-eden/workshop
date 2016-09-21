-- Validates table for JSON serialization.

-- Will raise error even at minor violation. (Counterpart of prepare().)

local is_array = request('^.^.array.is_array')

local visited

local verify
verify =
  function(t)
    if visited[t] then
      error('Table have common nodes. Cannot be saved in JSON.')
    end
    visited[t] = true
    if is_array(t) then
      for k in pairs(t) do
        if not is_integer(k) then
          error(('Key "%s" (%s) will not fit in JSON array.'):format(k, t))
        end
      end
    else
      for k in pairs(t) do
        if not is_string(k) then
          error(('Key "%s" [%s] has not string type.'):format(k, type(k)))
        end
      end
    end
    for _, v in pairs(t) do
      if is_table(v) then
        verify(v)
      end
    end
  end

return
  function(self, t, deep)
    assert_table(t)
    if (#t > 0) then
      error('Root table is array, not object.')
    end
    visited = {}
    verify(t)
  end
