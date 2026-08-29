-- Return leaf name of pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-08-29
]]

local is_directory = request('is_directory')
local self_dir = request('Syntels').self_dir

-- Export:
return
  function(Pathname)
    assert_table(Pathname)

    local leaf_name

    if is_directory(Pathname) then
      leaf_name = Pathname[#Pathname - 1]
    else
      leaf_name = Pathname[#Pathname]
    end

    if (leaf_name == '') then
      leaf_name = self_dir
    end

    return leaf_name
  end

--[[
  2026 #
]]
