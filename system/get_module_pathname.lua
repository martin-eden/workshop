-- For module name try to find it's file

--[[
  Author: Martin Eden
  Last mod.: 2026-06-01
]]

--[[
  For correct require()-ready module name return file pathname which
  was loaded as this module.

  Not all cases can be resolved: module may be loaded but we can't
  figure file's name. This is possible at least when
    * <package.loaded> was directly modified
    * module is loaded via custom function in <package.searchers>

  Returns nil if is unable to find file.
]]

-- Imports:
local normalize_name = request('!.file_system.file.normalize_name')

local get_module_pathname =
  function(module_name)
    assert_string(module_name)

    local pathname = package.searchpath(module_name, _G.package.path)

    if not pathname then return nil end

    return normalize_name(pathname)
  end

-- Export:
return get_module_pathname

--[[
  2018 # #
  2026-06-01
]]
