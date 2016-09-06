-- Reverse operation of to_array()

-- Not expect it will be ever used but need for functional completeness.

local is_array = request('is_array')

local to_table =
  function(t)
    if is_array(t) then
      setmetatable(t, nil)
    end
  end

return to_table
