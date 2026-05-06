-- Combine data and ranges tree to create table with structured data

--[[
  Author: Martin Eden
  Last mod.: 2026-05-06
]]

--[[
  Result structure

    <node>:
    (
      <key> [s] = [s] or <node>
    )
]]

-- Imports:
local create_string_value = request('!.concepts.RangesTree.StringValue.create')
local apply_ranges = request('!.concepts.RangesTree.apply_ranges')
local table_is_empty = request('!.table.is_empty')

local apply_ranges_tree
apply_ranges_tree =
  function(InputStr, Node)
    local Result = { }

    for key in pairs(Node.Children) do
      -- Retrieve data only if node has no children
      if table_is_empty(Node.Children[key].Children) then
        local OutputStr = create_string_value()
        apply_ranges(InputStr, Node:GetRanges(key), OutputStr)
        Result[key] = OutputStr:GetValue()
      else
        Result[key] =
          apply_ranges_tree(
            InputStr,
            Node.Children[key],
            Result[key]
          )
      end
    end

    return Result
  end

local apply_ranges_tree_root =
  function(data_str, RangesTree)
    local InputStr = create_string_value(data_str)

    Result = apply_ranges_tree(InputStr, RangesTree)

    return Result
  end

-- Export:
return apply_ranges_tree_root

--[[
  2026-05-05
  2026-05-06
]]
