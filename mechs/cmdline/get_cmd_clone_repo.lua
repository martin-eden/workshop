-- Return shell command to clone git repository

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local add_separator = request('!.concepts.path_name.add_separator')
local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(url, dest_dir)
    assert_string(url)
    assert_string(dest_dir)

    assert(dest_dir ~= '')

    dest_dir = normalize(add_separator(dest_dir))

    local command =
      { 'git', 'clone', url, dest_dir, '--quiet' }

    return shell_command.create(command)
  end

--[[
  2026 # #
]]
