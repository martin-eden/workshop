-- Return shell command to extract tar.gz file into given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-09-24
]]

local normalize = request('!.concepts.path_name.normalize')
local ShellCommand = request('!.concepts.ShellCommand')

return
  function(file_name, output_dir_name)
    local Command =
      {
        'tar',
        {
          '--extract',
          '--gzip',
          '--file',
          normalize(file_name),
          '--directory',
          normalize(output_dir_name),
        },
      }

    return ShellCommand.create(Command)
  end

--[[
  2026-09-24
]]
