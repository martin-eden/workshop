-- Return list of modules required by given module

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

--[[
  List always contains root module
]]

--[[
  Dependencies table is map:

    ((a -> b) (b -> c) ( a -> d))
    ->
    {
      ['a'] = { ['b'] = true, ['d'] = true },
      ['b'] = { ['c'] = true },
    }
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')

local get_module_dependencies =
  function(module_name)
    assert_string(module_name)

    local Result = { }

    local Dependencies_Map = get_dependencies()
    local Visited_Map = { }

    local visit
    visit =
      function(module_name)
        if Visited_Map[module_name] then return end

        local Deps = Dependencies_Map[module_name]
        if is_table(Deps) then
          for key in pairs(Deps) do
            visit(key)
          end
        end

        add_to_list(Result, module_name)
        Visited_Map[module_name] = true
      end

    local require_module_name = get_require_name(module_name)
    visit(require_module_name)

    return Result
  end

-- Export:
return get_module_dependencies

--[[
  2018
  2026-05-28
]]
