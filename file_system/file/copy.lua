-- Copy file, creating destination directory if needed

--[[
  Author: Martin Eden
  Last mod.: 2026-08-13
]]

--[[
  Copy file to given pathname.

  Unlike plain "cp", if destination directory does not exist,
  it is created.

  Returns true if operation succeeded.
]]

-- Imports:
local pathname_from_str = request('!.concepts.path_name.pathname_from_str')
local get_host_dir = request('!.concepts.path_name.get_host_dir')
local create_dir = request('!.file_system.directory.create')
local get_cmd_copy = request('!.mechs.cmdline.get_cmd_copy')

local copy_file =
  function(src_pathname, dest_pathname)
    assert_string(src_pathname)
    assert_string(dest_pathname)

    local dest_dir = get_host_dir(pathname_from_str(dest_pathname))

    create_dir(dest_dir)

    return get_cmd_copy(src_pathname, dest_pathname):Execute()
  end

-- Export:
return copy_file

--[[
  2026-08-13
]]
