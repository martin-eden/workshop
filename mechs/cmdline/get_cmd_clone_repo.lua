-- Return shell command to clone git repository

--[[
  Author: Martin Eden
  Last mod.: 2026-08-09
]]

-- Imports:
local add_separator = request('!.concepts.path_name.add_separator')
local normalize = request('!.concepts.path_name.normalize')
local ShellCommand = request('!.concepts.ShellCommand')

local get_cmd_clone_repo =
  function(url, dest_dir)
    assert_string(url)
    assert_string(dest_dir)

    assert(dest_dir ~= '')

    dest_dir = add_separator(dest_dir)
    dest_dir = normalize(dest_dir)

    local Command =
      {
        'git',
        {
          'clone',
          url,
          dest_dir,
          '--quiet',
        }
      }

    return ShellCommand.create(Command):ToString()
  end

-- Export:
return get_cmd_clone_repo

--[[
  2026-06-17
]]
