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

local normalize_name = request('!.file_system.file.normalize_name')
local split = request('!.string.split')
local file_exists = request('!.file_system.file.exists')

return
  function(module_name)
    assert_string(module_name)
    module_name = module_name:gsub('%.', '/')
    local name_patterns = split(package.path, ';')
    for i = 1, #name_patterns do
      local possible_file_name = name_patterns[i]
      possible_file_name = possible_file_name:gsub('%?', module_name)
      possible_file_name = normalize_name(possible_file_name)
      if file_exists(possible_file_name) then
        return possible_file_name
      end
    end
  end
