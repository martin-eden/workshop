--[[
  For correct module name, require()-ready,
  return file pathname which will be loaded as this module.

  * Not all cases can be resolved: module may be loaded but we can't
    figure file's name. This is possible at least when
    * <package.loaded> was directly modified
    * <require> overriden with custom function (in this case record
      for module in <package.loaded> may be absent)
    * module is loaded via custom function in <package.searchers>
]]

local normalize_name = request('!.file.normalize_name')

return
  function(module_name)
    assert_string(module_name)
    local result
    result = package.searchpath(module_name, _G.package.path)
    result = normalize_name(result)
    return result
  end
