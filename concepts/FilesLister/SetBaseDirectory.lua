-- Set base directory for lister

--[[
  Author: Martin Eden
  Last mod.: 2026-06-16
]]

-- Imports:
local add_dir_postfix = request('!.concepts.path_name.add_dir_postfix')
local normalize_name = request('!.concepts.path_name.normalize')

local SetBaseDir =
  function(Me, base_dir)
    assert_string(base_dir)

    base_dir = add_dir_postfix(base_dir)
    base_dir = normalize_name(base_dir)

    Me.BaseDir = base_dir
  end

-- Export:
return SetBaseDir

--[[
  2017-08-11
  2026-04-22
  2026-04-26
]]
