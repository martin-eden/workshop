-- Reverse operation of from_table()

-- Not expect it will be ever used but need for functional completeness.

local is_array = request('is_array')

return
  function(t)
    if is_array(t) then
      setmetatable(t, nil)
    end
  end
