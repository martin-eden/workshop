-- Change leaf values of tree

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

--[[
  Input:

    [t] Tree -- tree of values
    [f] change_func -- single-in single-out function to change value

  Example:

    ( { ['a'] = 1, 2 }, function(v) return v + 1 end )
                       ->
    { ['a'] = 2, 3 }
]]

local change_values_root =
  function(Tree, change_func)
    assert_table(Tree)
    assert_function(change_func)

    local change_values
    change_values =
      function(Node)
        for key, value in pairs(Node) do
          if is_table(value) then
            change_values(value)
          else
            Node[key] = change_func(value)
          end
        end
      end

    change_values(Tree)
  end

-- Export:
return change_values_root

--[[
  2026-05-31
]]
