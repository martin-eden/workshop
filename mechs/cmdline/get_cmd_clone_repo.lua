-- Return shell command to clone git repository

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

-- Imports:
local add_dir_postfix = request('!.concepts.path_name.add_dir_postfix')
local normalize = request('!.concepts.path_name.normalize')
local quote = request('!.concepts.shell.quote')
local glue_words = request('!.concepts.words.to_string')

local get_cmd_clone_repo =
  function(url, dest_dir)
    assert_string(url)
    assert_string(dest_dir)

    assert(dest_dir ~= '')

    dest_dir = add_dir_postfix(dest_dir)
    dest_dir = normalize(dest_dir)

    local Command =
      {
        'git',
        'clone',
        quote(url),
        quote(dest_dir),
        '--quiet',
      }

    return glue_words(Command)
  end

-- Export:
return get_cmd_clone_repo

--[[
  2026-06-17
]]
