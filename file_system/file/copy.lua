-- Copy file, creating destination directory if needed

--[[
  Author: Martin Eden
  Last mod.: 2026-09-10
]]

--[[
  Copy file to given pathname.

  Unlike plain "cp", if destination directory does not exist,
  it is created.

  Returns true if operation succeeded.
]]

local get_host_dir = request('!.concepts.path_name.get_host_dir_str')
local create_dir = request('!.file_system.directory.create')
local get_cmd_copyfile = request('!.mechs.cmdline.get_cmd_file_copy')

-- Export:
return
  function(src_pathname, dest_pathname)
    assert_string(src_pathname)
    assert_string(dest_pathname)

    local dest_dir = get_host_dir(dest_pathname)
    create_dir(dest_dir)

    return get_cmd_copyfile(src_pathname, dest_pathname):Execute()
  end

--[[
  2026 #
]]
