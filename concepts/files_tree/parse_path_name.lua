-- Parse pathname and add it to our tree

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

--[[
  It still looks broken but I revisited it

  pathname_from_str() can return list with empty strings on ends.
  Empty at start means absolute path. Empty at end means directory.
]]

-- Imports:
local pathname_from_str = request('!.concepts.path_name.pathname_from_str')

local updir = '..'

local ParsePathname =
  function(Me, path_name, is_file)
    local Pathname = pathname_from_str(path_name)
    local CurrentNode = Me.tree

    for _, part_name in ipairs(Pathname) do
      if (part_name == updir) then
        if not CurrentNode.parent then
          CurrentNode.parent =
            {
              name = '',
              children = { [CurrentNode.name] = CurrentNode },
            }
        end
        CurrentNode = CurrentNode.parent
      else
        if not CurrentNode.children[part_name] then
          CurrentNode.children[part_name] =
            {
              name = part_name,
              parent = CurrentNode,
              children = { },
            }
        end
        CurrentNode = CurrentNode.children[part_name]
      end
    end

    if is_file and not next(CurrentNode.children) then
      CurrentNode.is_file = true
    end
  end

-- Export:
return ParsePathname

--[[
  2017-09
  2026-06-12
]]
