-- Combine tree with data and tree with data ranges to one data value

--[[
  Author: Martin Eden
  Last mod.: 2026-05-10
]]

local fold_tree_root =
  function(DataTree, RangesTree, ValueClass)
    local Result = new(ValueClass)

    local fold_tree
    fold_tree =
      function(DataNode, RangesNode, name_prefix)
        for key, val in pairs(DataNode) do
          local subnode_name = name_prefix .. key

          if not is_table(val) then
            local NodeRanges = RangesTree:GetRanges(subnode_name)

            for idx, NodeRange in ipairs(NodeRanges) do
              Result:SetRangeValue(NodeRange, val)
            end
          else
            fold_tree(
              val,
              RangesNode.Children[key],
              subnode_name .. '.'
            )
          end
        end
      end

    fold_tree(DataTree, RangesTree, '')

    return Result:GetValue()
  end

-- Export:
return fold_tree_root

--[[
  2026-05-07
  2026-05-09
]]
