-- Return true if pathname denotes directory

--[[
  Author: Martin Eden
  Last mod.: 2026-04-25
]]

-- Imports:
local ends_with = request('!.string.ends_with')
local parse_pathname = request('parse')

-- Check that pathname is directory. We're not doing any file access
local is_directory =
  function(path_name)
    return ends_with(parse_pathname(path_name).FullName, '/')
  end

-- Export:
return is_directory

--[[
  2026-04-25
]]
