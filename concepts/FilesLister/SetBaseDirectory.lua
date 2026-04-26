-- Set base directory for lister

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

-- Imports:
local add_dir_postfix = request('!.string.file_name.add_dir_postfix')
local normalize_name = request('!.file_system.file.normalize_name')

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
