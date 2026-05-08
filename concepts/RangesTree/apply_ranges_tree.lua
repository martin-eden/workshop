-- Combine data and ranges tree to create data tree

--[[
  Author: Martin Eden
  Last mod.: 2026-05-08
]]

--[[
  Result structure

    <node>:
    (
      <key> [s] = [s] or <node>
    )
]]

-- Imports:
local table_is_empty = request('!.table.is_empty')
local apply_ranges = request('apply_ranges')

-- Produce data tree for given data, ranges tree and data creator
local apply_ranges_tree_root =
  function(data, RangesTree, create_data)
    InputData = create_data(data)

    local apply_ranges_tree
    apply_ranges_tree =
      function(Node, name_prefix)
        local Result = { }

        for key in pairs(Node.Children) do
          local subnode_name = name_prefix .. key
          -- Retrieve data only if node has no children
          if table_is_empty(Node.Children[key].Children) then
            local OutputData = create_data()
            apply_ranges(
              InputData,
              RangesTree:GetRanges(subnode_name),
              OutputData
            )
            Result[key] = OutputData:GetValue()
          else
            Result[key] =
              apply_ranges_tree(Node.Children[key], subnode_name .. '.')
          end
        end

        return Result
      end

    return apply_ranges_tree(RangesTree, '')
  end

-- Export:
return apply_ranges_tree_root

--[[
  2026-05-05
  2026-05-06
  2026-05-07
]]
