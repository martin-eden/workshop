-- Set base directory for lister

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local directory_exists = request('!.file_system.directory.exists')
local add_dir_postfix = request('!.string.file_name.add_dir_postfix')

--[[
  Set base directory

  Assure that BaseDir name ends on '/' and directory exists.
]]
local SetBaseDir =
  function(Me, base_dir)
    assert_string(base_dir)
    assert(directory_exists(base_dir))

    base_dir = add_dir_postfix(base_dir)

    Me.BaseDir = base_dir
  end

-- Export:
return SetBaseDir

--[[
  2017-08-11
  2026-04-22
]]
