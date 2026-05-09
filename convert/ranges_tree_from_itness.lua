-- Convert ranges tree data from Itness format

--[[
  Author: Martin Eden
  Last mod.: 2026-05-09
]]

-- Imports:
local create_range = request('!.concepts.RangesTree.Range.create')
local RangesTreeClass = request('!.concepts.RangesTree.RangesTree.Interface')

local deserialize_range =
  function(NodeIs)
    local range_start = tonumber(NodeIs[1])
    local range_len = tonumber(NodeIs[2])

    return create_range(range_start, range_len)
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
  function(RangesTreeIs, RangesTree, name_prefix)
    local node_name = name_prefix

    for key, val in ipairs(RangesTreeIs) do
      if looks_like_range(key, val) then
        RangesTree:AddRange(node_name, deserialize_range(val))
      end

      if looks_like_name(key, val) then
        node_name = name_prefix .. val

        RangesTree:AddName(node_name)
      end

      if looks_like_node(key, val) then
        ranges_tree_from_itness(
          val,
          RangesTree,
          node_name .. '.'
        )
      end
    end
  end

local ranges_tree_from_itness_root =
  function(RangesTreeIs)
    local RangesTree = RangesTreeClass.create()

    ranges_tree_from_itness(RangesTreeIs, RangesTree, '')

    return RangesTree
  end

-- Export:
return ranges_tree_from_itness_root

--[[
  2026-05-05
]]
