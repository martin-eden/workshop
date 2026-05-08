-- Convert data tree with named values to Itness format

--[[
  Author: Martin Eden
  Last mod.: 2026-05-08
]]

--[[
  Input structure

    <node> [t]:
      <key> [s] = [s] -- terminal string node
      or
      <key> [s] = <node> [t] -- child node
]]

-- Imports:
local ordered_pass = request('!.table.ordered_pass')
local add_to_list = request('!.concepts.list.add_item')

local data_tree_to_itness
data_tree_to_itness =
  function(DataTree)
    local ResultIs = { }

    for key, val in ordered_pass(DataTree) do
      local NodeIs = { }
      add_to_list(NodeIs, key)
      if is_string(val) then
        add_to_list(NodeIs, val)
      elseif is_table(val) then
        add_to_list(NodeIs, data_tree_to_itness(val))
      end
      add_to_list(ResultIs, NodeIs)
    end

    return ResultIs
  end

-- Export:
return data_tree_to_itness

--[[
  2026-05-05
]]
