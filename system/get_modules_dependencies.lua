--[[
  Return list of modules required for given modules.
]]

local get_module_dependencies = request('get_module_dependencies')

return
  function(modules)
    assert_table(modules)
    local deps = {}
    for i = 1, #modules do
      local module_name = modules[i]
      assert_string(module_name)
      deps[i] = get_module_dependencies(module_name)
    end

    local result = {}

    local processed = {}
    for i = 1, #deps do
      for j = 1, #deps[i] do
        local module_name = deps[i][j]
        if not processed[module_name] then
          result[#result + 1] = module_name
          processed[module_name] = true
        end
      end
    end

    return result
  end
