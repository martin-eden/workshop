-- Return true if pathname denotes directory

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

local empty = ''
local self_dir = '.'
local upper_dir = '..'

local is_directory =
  function(Pathname)
    assert_table(Pathname)

    local last_node = Pathname[#Pathname]

    return
      (last_node == empty) or
      (last_node == self_dir) or
      (last_node == upper_dir)
  end

-- Export:
return is_directory

--[[
  2026-04 #
  2026-06-12
]]
