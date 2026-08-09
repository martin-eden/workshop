-- Return shell command to download file by URL

--[[
  Author: Martin Eden
  Last mod.: 2026-08-09
]]

-- Imports:
local normalize = request('!.concepts.path_name.normalize')
local ShellCommand = request('!.concepts.ShellCommand')

local get_cmd_download_file =
  function(url_str, pathname)
    assert_string(url_str)
    assert_string(pathname)

    --[[
      We prefer "curl" because in case of error it does not create
      zero-sized output file.
    ]]
    local Command =
      {
        'curl',
        {
          '--output',
          normalize(pathname),
          url_str,
          '--silent',
          '--show-error',
        },
      }

    return ShellCommand.create(Command):ToString()
  end

-- Export:
return get_cmd_download_file

--[[
  2026-06-15
  2026-08-09
]]
