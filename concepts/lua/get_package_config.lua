-- Get named map for Lua's "package.config" contents

--[[
  Author: Martin Eden
  Last mod.: 2026-05-08
]]

--[[
  Result structure

    (
      DirsSep [s] -- "/" directories separator
      ItemsSep [s] -- ";" separator between search paths
      CaptureChar [s] -- "?" to place module name instead of it
      ExecDirAlias [s] -- "!" some custom shit for executable's dir
      ItemTerminator [s] -- "-" terminator at which name is truncated
    )
]]

-- Imports:
local Lines = request('!.concepts.Lines.Interface')

local parse_package_config =
  function(config_str)
    local Lines = new(Lines)

    Lines:FromString(config_str)

    local Result =
      {
        DirsSep = Lines:GetLineAt(1),
        ItemsSep = Lines:GetLineAt(2),
        CaptureChar = Lines:GetLineAt(3),
        ExecDirAlias = Lines:GetLineAt(4),
        ItemTerminator = Lines:GetLineAt(5),
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
