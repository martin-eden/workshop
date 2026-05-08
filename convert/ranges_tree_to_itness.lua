-- Convert ranges tree data to Itness format

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

-- Imports:
local ordered_pass = request('!.table.ordered_pass')
local add_to_list = request('!.concepts.list.add_item')

local ranges_comparator =
  function(RangeA, RangeB)
    local a_start = RangeA:GetStart()
    local a_len = RangeA:GetLength()
    local b_start = RangeB:GetStart()
    local b_len = RangeB:GetLength()

    if (a_start < b_start) then return true end
    if (a_start > b_start) then return false end

    if (a_len < b_len) then return false end
    if (a_len > b_len) then return true end

    return false
  end

local ranges_tree_comparator =
  function(RecA, RecB)
    local a_key = RecA.key
    local a_val = RecA.value
    local b_key = RecB.key
    local b_val = RecB.value

    if not is_integer(a_key) and is_integer(b_key) then return false end
    if is_integer(a_key) and not is_integer(b_key) then return true end

    if is_integer(a_key) and is_integer(b_key) then
      return a_key < b_key
    end

    if not is_integer(a_key) and not is_integer(b_key) then
      assert_table(a_val)
      assert_table(b_val)

      local A_Range = a_val[1]
      local B_Range = b_val[1]

      return ranges_comparator(A_Range, B_Range)
    end

    return false
  end

local serialize_range =
  function(Range)
    return
      {
        tostring(Range:GetStart()),
        tostring(Range:GetLength()),
      }
  end

local ranges_tree_to_itness
ranges_tree_to_itness =
  function(RangesTree)
    local ResultIs = { }

    for key, val in ordered_pass(RangesTree, ranges_tree_comparator) do
      if is_integer(key) then
        add_to_list(ResultIs, serialize_range(val))
      end

      if not (is_string(key) and is_table(val)) then goto next end

      add_to_list(ResultIs, key)

      local NodeIs

      NodeIs = ranges_tree_to_itness(val)
      add_to_list(ResultIs, NodeIs)

      ::next::
    end

    return ResultIs
  end

-- Export:
return ranges_tree_to_itness

--[[
  2026-05-05
]]
