-- Convert ranges tree data from Itness format

--[[
  Author: Martin Eden
  Last mod.: 2026-11-26
]]

local range = request('!.concepts.RangesTree.Range.Interface')
local max = math.max

local convert_node
convert_node =
  function(node_is, ranges_tree, name_prefix)
    local name = name_prefix .. node_is[1]
    local start = tonumber(node_is[2])
    local contents = node_is[3]

    ranges_tree:AddName(name)

    local len
    if is_table(contents) then
      local max_end = 0
      for _, child in ipairs(contents) do
        local child_end =
          convert_node(child, ranges_tree, name .. '.')
        max_end = max(max_end, child_end)
      end
      len = max_end
    elseif is_string(contents) then
      len = tonumber(contents)
    end

    ranges_tree:AddRange(name, range.create(start, len))
    return start + len - 1
  end

local ranges_tree_class =
  request('!.concepts.RangesTree.RangesTree.Interface')

-- Export:
return
  function(ranges_tree_is)
    local ranges_tree = ranges_tree_class.create()
    for _, node_is in ipairs(ranges_tree_is) do
      convert_node(node_is, ranges_tree, '')
    end
    return ranges_tree
  end

--[[
  2026 # #
  2026-11-26
]]
