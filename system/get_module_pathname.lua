-- Try to find file by module name

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

--[[
  For correct require()-ready module name return file pathname can be
  loaded as this module. Also return flag that file is binary.

  Not all cases can be resolved: module may be loaded but we can't
  figure file's name. Possible cases for this:
    * <package.loaded> was directly modified
    * module is loaded via custom function in <package.searchers>
    * module is system. Like "os". Or "_G".

  Returns nil if no file found.
]]

-- Imports:
local normalize_name = request('!.concepts.path_name.normalize')

local get_module_pathname =
  function(module_name)
    assert_string(module_name)

    local source_files_path = _G.package.path
    local binary_files_path = _G.package.cpath
    local is_binary = false

    local pathname =
      package.searchpath(module_name, source_files_path)

    if not pathname then
      pathname = package.searchpath(module_name, binary_files_path)
      if pathname then
        is_binary = true
      end
    end

    if not pathname then return end

    return normalize_name(pathname), is_binary
  end

-- Export:
return get_module_pathname

--[[
  2018 # #
  2026-06-01
  2026-06-05
]]
