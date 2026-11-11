-- Return shell command to extract tar.gz file into given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(file_name, output_dir_name)
    local command =
      {
        'tar',
        '--extract',
        '--gzip',
        '--file',
        normalize(file_name),
        '--directory',
        normalize(output_dir_name),
      }

    return shell_command.create(command)
  end

--[[
  2026-09-24
]]
