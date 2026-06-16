-- Function to create "is_<type>" family of global functions

--[[
  Author: Martin Eden
  Last mod.: 2026-06-16
]]

--[[
  It spawns "is_nil", "is_boolean", ... for all Lua data types.
  Also it spawns "is_integer" and "is_float" for number type.
]]

-- Imports:
local TypeNames = request('!.concepts.lua.TypeNames')
local NumberTypeNames = request('!.concepts.lua.NumberTypeNames')

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

local install_is_functions =
  function()
    for _, type_name in ipairs(TypeNames) do
      _G['is_' .. type_name] = type_is(type_name)
    end
    for _, math_type_name in ipairs(NumberTypeNames) do
      _G['is_' .. math_type_name] = number_is(math_type_name)
    end
  end

-- Export:
return install_is_functions

--[[
  2018-02
  2020 #
  2022 #
  2024 #
  2026-04-22
]]
