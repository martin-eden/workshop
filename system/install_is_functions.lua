--[[
  Function to spawn "is_<type>" family of global functions.
]]

local data_types = request('!.lua.data_types')

local generic_is =
  function(type_name)
    return
      function(val)
        local result, err_msg
        result = (type(val) == type_name)
        if not result then
          err_msg =
            ('Value "%s" has type <%s>, not <%s>.'):
            format(val, type(val), type_name)
        end
        return result, err_msg
      end
  end

return
  function()
    for _, type_name in ipairs(data_types) do
      _G['is_' .. type_name] = generic_is(type_name)
    end

    _G.is_integer =
      function(n)
        local result, err_msg
        result = (math.type(n) == 'integer')
        if not result then
          err_msg = ('math.type(<%s> %s) ~= "integer"'):format(type(n), n)
        end
        return result, err_msg
      end
  end
