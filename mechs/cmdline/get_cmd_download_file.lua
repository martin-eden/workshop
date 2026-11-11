-- Return shell command to download file by URL

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(url_str, pathname)
    assert_string(url_str)
    assert_string(pathname)

    --[[
      We prefer "curl" because in case of error it does not create
      zero-sized output file.
    ]]
    local command =
      {
        'curl',
        url_str,
        '--output',
        normalize(pathname),
        '--location',
        '--silent',
        '--show-error',
      }

    return shell_command.create(command)
  end

--[[
  2026 # # #
]]
