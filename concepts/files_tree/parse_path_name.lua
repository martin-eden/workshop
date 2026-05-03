-- Parse pathname and add it to our tree

--[[
  Author: Martin Eden
  Last mod.: 2026-05-03
]]

local parse_name = request('^.path_name.parse')

local level_up_str = '..'

return
  function(self, path_name, is_file)
    error('Not synced with [path_name.parse] interface')

    local components = parse_name(path_name)
    local current_node = self.tree
    for i = 1, #components.Path do
      local part_name = components[i]
      if (part_name == level_up_str) then
          if not current_node.parent then
            current_node.parent =
              {
                name = '',
                children =
                  {
                    [current_node.name] = current_node,
                  },
              }
          end
          current_node = current_node.parent
      else
        if not current_node.children[part_name] then
          current_node.children[part_name] =
            {
              name = part_name,
              parent = current_node,
              children = {},
            }
        end
        current_node = current_node.children[part_name]
      end
    end
    if is_file and not next(current_node.children) then
      current_node.is_file = true
    end
  end

--[[
  2017-09
]]
