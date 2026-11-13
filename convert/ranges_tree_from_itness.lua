-- Convert ranges tree data from Itness format

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local deserialize_range
do
  local range = request('!.concepts.RangesTree.Range.Interface')
  deserialize_range =
    function(node)
      local start = tonumber(node[1])
      local len = tonumber(node[2])

      return range.create(start, len)
    end
end

local looks_like_range =
  function(key_is, val_is)
    return
      is_table(val_is) and
      (#val_is == 2) and
      is_integer(tonumber(val_is[1])) and
      is_integer(tonumber(val_is[2]))
  end

local looks_like_name =
  function(key_is, val_is)
    return is_string(val_is)
  end

local looks_like_node =
  function(key_is, val_is)
    return
      not looks_like_name(key_is, val_is) and
      not looks_like_range(key_is, val_is)
  end

local ranges_tree_from_itness
ranges_tree_from_itness =
  function(ranges_tree_is, ranges_tree, name_prefix)
    local node_name = name_prefix

    for key, val in ipairs(ranges_tree_is) do
      if looks_like_range(key, val) then
        ranges_tree:AddRange(node_name, deserialize_range(val))
      end

      if looks_like_name(key, val) then
        node_name = name_prefix .. val
        ranges_tree:AddName(node_name)
      end

      if looks_like_node(key, val) then
        ranges_tree_from_itness(val, ranges_tree, node_name .. '.')
      end
    end
  end

local ranges_tree_class =
  request('!.concepts.RangesTree.RangesTree.Interface')

-- Export:
return
  function(ranges_tree_is)
    local ranges_tree = ranges_tree_class.create()
    ranges_tree_from_itness(ranges_tree_is, ranges_tree, '')
    return ranges_tree
  end

--[[
  2026 # #
]]
