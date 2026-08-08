-- Set base directory for lister

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

-- Imports:
local add_separator = request('!.concepts.path_name.add_separator')
local normalize_name = request('!.concepts.path_name.normalize')

local SetBaseDir =
  function(Me, base_dir)
    assert_string(base_dir)

    base_dir = add_separator(base_dir)
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
