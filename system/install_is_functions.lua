--[[
  Function to spawn "is_<type>" family of global functions.
]]

local data_types = request('!.lua.data_types')

local generic_is =
  function(type_name)
    return
      function(val)
        return (type(val) == type_name)
      end
  end

return
  function()
    for _, type_name in ipairs(data_types) do
      _G['is_' .. type_name] = generic_is(type_name)
    end

    _G.is_integer =
      function(n)
        return (math.type(n) == 'integer')
      end
  end
