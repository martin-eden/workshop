-- Save dependecies from [observe_modules] to .dot format

--[[
  Author: Martin Eden
  Last mod.: 2026-10-18
]]

-- Experimental module

--[[
  [observe_modules] returns dependencies as second argument
  in table like

    { ['a.b'] = { ['c.d'] = true, ['e'] = true } ... }

  We want to convert it to some graph. We need format like

    {
      [1] = { [1] = 'a.b', [2] = 'c.d', [3] = 'e' ... },
      [2] = { [1] = { 2, 3 } ... },
    }

  Also we replace "a.b" to "a\nb" (literal backslash and "en")
  because we want to have multiline labels for module names.

  (We need proper C quoting function for this but there is no any yet.)
]]


local add_to_list = request('!.concepts.list.add_item')
local invert = request('!.table.invert')
local str_gsub = string.gsub
local compile = request('!.concepts.coder_graphviz.compile')

return
  function(Deps, OutputStream)
    local Labels = { }
    do
      local UsedLabels_Map = { }

      local labels_population_process =
        function(label)
          if not UsedLabels_Map[label] then
            add_to_list(Labels, label)
            UsedLabels_Map[label] = true
          end
        end

      for src_module, ModuleDeps in pairs(Deps) do
        labels_population_process(src_module)
        for dest_module in pairs(ModuleDeps) do
          labels_population_process(dest_module)
        end
      end
    end

    local IdFromLabel_Map = invert(Labels)

    for idx, label in ipairs(Labels) do
      Labels[idx] = str_gsub(label, '%.', '\\n')
    end

    local Links = { }
    do
      for i = 1, #Labels do
        Links[i] = { }
      end
      for src_module, ModuleDeps in pairs(Deps) do
        local NodeLinks = { }
        for dest_module in pairs(ModuleDeps) do
          add_to_list(NodeLinks, IdFromLabel_Map[dest_module])
        end
        Links[IdFromLabel_Map[src_module]] = NodeLinks
      end
    end

    compile(Labels, Links, OutputStream)
  end

--[[
  2026-10-15
]]
