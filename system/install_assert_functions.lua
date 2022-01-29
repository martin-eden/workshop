--[[
  Function to spawn "assert_<type>" family of global functions.
]]

local data_types = request('!.lua.data_types')

local generic_assert =
  function(is_checker)
    return
      function(val, responsibility_level)
        local responsibility_level = (responsibility_level or 1)
        local result, err_msg = is_checker(val)
        if not result then
          error(err_msg, responsibility_level + 1)
        end
      end
  end

return
  function()
    for _, type_name in ipairs(data_types) do
      _G['assert_' .. type_name] = generic_assert(_G['is_' .. type_name])
    end
    _G.assert_integer = generic_assert(_G.is_integer)
    _G.assert_float = generic_assert(_G.is_float)
  end
