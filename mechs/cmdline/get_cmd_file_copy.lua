-- Return shell command to copy file to another name/location.

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local pathname_from_str = request('!.concepts.path_name.pathname_from_str')
local get_file_name = request('!.concepts.path_name.get_name')
local get_host_dir = request('!.concepts.path_name.get_host_dir_str')
local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(src_pathname, dest_pathname)
    --[[
      Implementation smartness details

      When called to copy file to same name but in another directory
      file name is not mentioned in destination,
      returned command is like "cp src_dir/file_a dest_dir/".
    ]]

    local src_filename = get_file_name(pathname_from_str(src_pathname))
    local dest_filename = get_file_name(pathname_from_str(dest_pathname))

    if (src_filename == dest_filename) then
      dest_pathname = get_host_dir(dest_pathname)
    end

    local command =
      { 'cp', normalize(src_pathname), normalize(dest_pathname) }

    return shell_command.create(command)
  end

--[[
  2018 #
  2024 #
  2026 # # # # #
]]
