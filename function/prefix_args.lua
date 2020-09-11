--[[
  Create function that calls base function with additional
  first arguments.
]]

return
  function(base_func, ...)
    local prefix_args = table.pack(...)
    return
      function(...)
        return base_func(table.unpack(prefix_args), ...)
      end
  end
