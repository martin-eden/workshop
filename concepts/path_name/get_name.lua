-- Return leaf name of pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

-- Imports:
local Syntels = request('Syntels')
local is_directory = request('is_directory')

local empty = Syntels.empty
local self_dir = Syntels.self_dir

local get_name =
  function(Pathname)
    assert_table(Pathname)

    local leaf_name

    if is_directory(Pathname) then
      leaf_name = Pathname[#Pathname - 1]
    else
      leaf_name = Pathname[#Pathname]
    end

    if (leaf_name == empty) then
      leaf_name = self_dir
    end

    return leaf_name
  end

-- Export:
return get_name

--[[
  2026-06-12
]]
