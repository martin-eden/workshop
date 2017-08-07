--[[
  Receives correct module name, require()-ready.
  Returns file pathname which will be loaded as this module.

  Notes
    * Uses _G.package.path.
    * Not all cases can be resolved: module may be loaded but we can't
      figure file's name. This is possible at least when
        * require() may be overriden to custom function
        * module is loaded via custom function in package.searchers[]
]]

local split = request('!.string.split')
local file_exists = request('!.file.exists')

return
  function(module_name)
    assert_string(module_name)
    module_name = module_name:gsub('%.', '/')
    local name_patterns = split(package.path, ';')
    for i = 1, #name_patterns do
      local possible_file_name = name_patterns[i]
      possible_file_name = possible_file_name:gsub('%?', module_name)
      if file_exists(possible_file_name) then
        return possible_file_name
      end
    end
  end
