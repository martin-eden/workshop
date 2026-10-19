-- Save dependecies from [observe_modules] to .dot format

--[[
  Author: Martin Eden
  Last mod.: 2026-10-19
]]

-- Experimental module

--[[
  [observe_modules] returns dependencies as second argument
  in table like

    { ['a.b'] = { ['c.d'] = true, ['e'] = true } ... }

  We want to convert it to graph in format like this:

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

return
  function(Deps)
    local Labels = { }
    do
      local UsedLabels_Map = { }

      local add_label =
        function(label)
          if UsedLabels_Map[label] then return end
          add_to_list(Labels, label)
          UsedLabels_Map[label] = true
        end

      for src_module, ModuleDeps in pairs(Deps) do
        add_label(src_module)
        for dest_module in pairs(ModuleDeps) do
          add_label(dest_module)
        end
      end
    end

    local IdFromLabel_Map = invert(Labels)

    local Links = { }
    do
      for src_module, ModuleDeps in pairs(Deps) do
        local NodeLinks = { }
        for dest_module in pairs(ModuleDeps) do
          add_to_list(NodeLinks, IdFromLabel_Map[dest_module])
        end
        Links[IdFromLabel_Map[src_module]] = NodeLinks
      end
    end

    -- Make labels multiline: ( "a.b" ) -> ( "a" newline "b" )
    for idx, label in ipairs(Labels) do
      Labels[idx] = str_gsub(label, '%.', '\\n')
    end

    return { Labels, Links }
  end

--[[
  2026-10-15
  2026-10-19
]]
