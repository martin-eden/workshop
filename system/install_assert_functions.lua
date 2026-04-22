-- Function to create "assert_<type>" global functions

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local DataTypes = request('!.lua.data_types')
local MathTypes = request('!.lua.data_mathtypes')

local spawn_assert_func =
  function(type_name)
    local checker = _G['is_'.. type_name]

    assert(checker)

    return
      function(val)
        if not checker(val) then
          local err_msg =
            string.format('assert_%s(%s)', type_name, tostring(val))

          error(err_msg)
        end
      end
  end

local install_assert_funcs =
  function()
    for _, type_name in ipairs(DataTypes) do
      _G['assert_' .. type_name] = spawn_assert_func(type_name)
    end

    for _, number_type_name in ipairs(MathTypes) do
      _G['assert_' .. number_type_name] = spawn_assert_func(number_type_name)
    end
  end

-- Export:
return install_assert_funcs

--[[
  2018-02
  2020-01
  2022-01
  2024-03
  2026-04-22
]]
