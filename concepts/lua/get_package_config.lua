-- Get named map for Lua's "package.config" contents

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

--[[
  Result structure

    (
      [s] dirs_sep -- "/" directories separator
      [s] items_sep -- ";" separator between search paths
      [s] capture_char -- "?" to place module name instead of it
      [s] exec_dir_alias -- "!" some custom shit for executable's dir
      [s] name_terminator -- "-" terminator at which name is truncated
    )
]]

-- Imports:
local lines_from_str = request('!.convert.lines_from_str')

local parse_package_config =
  function(config_str)
    local Lines = lines_from_str(config_str)

    return
      {
        dirs_sep = Lines[1],
        items_sep = Lines[2],
        capture_char = Lines[3],
        exec_dir_alias = Lines[4],
        name_terminator = Lines[5],
      }
  end

local get_package_config =
  function()
    return parse_package_config(_G.package.config)
  end

-- Export:
return get_package_config

--[[
  2026-05-08
  2026-05-28
]]
