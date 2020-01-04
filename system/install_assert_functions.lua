--[[
  Function to spawn "assert_<type>" family of global functions.
]]

local data_types = request('!.lua.data_types')

local generic_assert =
  function(type_name)
    return
      function(val, responsibility_level)
        local responsibility_level = (responsibility_level or 1)
        if (type(val) ~= type_name) then
          error(
            ('Argument must have a type "%s", not "%s".'):
            format(type_name, type(val)),
            responsibility_level + 1
          )
        end
      end
  end

return
  function()
    for _, type_name in ipairs(data_types) do
      _G['assert_' .. type_name] = generic_assert(type_name)
    end

    _G.assert_integer =
      function(a, responsibility_level)
        local responsibility_level = (responsibility_level or 1)
        if (math.type(a) ~= 'integer') then
          error(
            ('Argument must be integer, not %s.'):format(type(a)),
            responsibility_level + 1
          )
        end
      end
  end
