-- Return set of modules required for given set of modules

--[[
  Input

    table

      Sequence of module names.

  Output

    table

      Sequence of module names.

  So if module "a" requires "lib" and module "b" requires it,
  result of call ({'a', 'b'}) will be ({'lib'}).
]]

-- Last mod.: 2024-03-02

local GetModuleDependencies = request('get_module_dependencies')

return
  function(Modules)
    assert_table(Modules)

    local UnitedSet = {}
    local UnitedList = {}

    for _, ModuleName in ipairs(Modules) do
      local ModuleDependencies = {}

      ModuleDependencies = GetModuleDependencies(ModuleName)

      for _, DependencyName in ipairs(ModuleDependencies) do
        if UnitedSet[DependencyName] then
          goto Continue
        end

        UnitedSet[DependencyName] = true
        table.insert(UnitedList, DependencyName)

        ::Continue::
      end
    end

    return UnitedList
  end

--[[
  2018-02-05
  2024-03-02
]]
