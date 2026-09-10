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

local pathname_from_str = request('!.concepts.path_name.pathname_from_str')
local pathname_to_str = request('!.concepts.path_name.pathname_to_str')
local get_host_dir = request('!.concepts.path_name.get_host_dir')
local create_dir = request('!.file_system.directory.create')
local get_cmd_copyfile = request('!.mechs.cmdline.get_cmd_file_copy')

-- Export:
return
  function(src_pathname, dest_pathname)
    assert_string(src_pathname)
    assert_string(dest_pathname)

    local dest_dir =
      pathname_to_str(get_host_dir(pathname_from_str(dest_pathname)))
    create_dir(dest_dir)

    return get_cmd_copyfile(src_pathname, dest_pathname):Execute()
  end

--[[
  2026 #
]]
