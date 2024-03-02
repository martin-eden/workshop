-- Function to spawn "is_<type>" family of global functions.

--[[
  It spawns "is_nil", "is_boolean", ... for all Lua data types.
  Also it spawns "is_integer" and "is_float" for number type.
]]

--[[
  Design

    f(:any) -> bool

    Original design was

      f(:any) -> bool, (string or nil)

      Use case was "assert(is_number(x))" which will automatically
      provide error message when "x" is not a number.

      Today I prefer less fancy designs. Caller has enough information
      to build error message itself.
]]

-- Last mod.: 2024-03-02

local data_types = request('!.lua.data_types')
local data_mathtypes = request('!.lua.data_mathtypes')

local type_is =
  function(type_name)
    return
      function(val)
        return (type(val) == type_name)
      end
  end

local number_is =
  function(type_name)
    return
      function(val)
        --[[
          math.type() throws error for non-number types.
          This function returns "false" for non-number types.
        ]]
        if not is_number(val) then
          return false
        end
        return (math.type(val) == type_name)
      end
  end

return
  function()
    for _, type_name in ipairs(data_types) do
      _G['is_' .. type_name] = type_is(type_name)
    end
    for _, math_type_name in ipairs(data_mathtypes) do
      _G['is_' .. math_type_name] = number_is(math_type_name)
    end
  end

--[[
  2018-02
  2020-01
  2022-01
  2024-03 Changed design
]]
