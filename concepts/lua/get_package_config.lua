-- Get named map for Lua's "package.config" contents

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

--[[
  Result structure

    (
      [s] DirsSep -- "/" directories separator
      [s] ItemsSep -- ";" separator between search paths
      [s] CaptureChar -- "?" to place module name instead of it
      [s] ExecDirAlias -- "!" some custom shit for executable's dir
      [s] ItemTerminator -- "-" terminator at which name is truncated
    )
]]

-- Imports:
local lines_from_str = request('!.convert.lines_from_str')

local parse_package_config =
  function(config_str)
    local Lines = lines_from_str(config_str)

    local Result =
      {
        DirsSep = Lines[1],
        ItemsSep = Lines[2],
        CaptureChar = Lines[3],
        ExecDirAlias = Lines[4],
        ItemTerminator = Lines[5],
      }

    return Result
  end

local get_package_config =
  function()
    return parse_package_config(_G.package.config)
  end

-- Export:
return get_package_config

--[[
  2026-05-08
]]
