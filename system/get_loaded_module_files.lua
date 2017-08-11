--[[
  Returns a list of filenames for used modules.

  Notes
    * There is not always a file name for module.
    * There is not always we can determine file name for module.

  Uses _G.package.loaded.
]]

local get_module_location = request('get_module_location')

local get_module_names =
  function()
    local result = {}
    for k in pairs(package.loaded) do
      result[#result + 1] = k
    end
    return result
  end

return
  function()
    local result = {}
    local modules = get_module_names()
    for i = 1, #modules do
      result[#result + 1] = get_module_location(modules[i])
    end
    return result
  end
