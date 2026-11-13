-- Convert ranges tree data to Itness format

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local ordered_pass = request('!.table.ordered_pass')
local add_to_list = request('!.concepts.list.add_item')

local ranges_comparator =
  function(range_a, range_b)
    local a_start = range_a:GetStart()
    local a_len = range_a:GetLength()
    local b_start = range_b:GetStart()
    local b_len = range_b:GetLength()

    if (a_start < b_start) then return true end
    if (a_start > b_start) then return false end

    if (a_len < b_len) then return false end
    if (a_len > b_len) then return true end

    return false
  end

local ranges_tree_comparator =
  function(a_rec, b_rec)
    local a_key = a_rec.key
    local b_key = b_rec.key
    local a_val = a_rec.value
    local b_val = b_rec.value

    if not is_integer(a_key) and is_integer(b_key) then return false end
    if is_integer(a_key) and not is_integer(b_key) then return true end

    if is_integer(a_key) and is_integer(b_key) then
      return a_key < b_key
    end

    if not is_integer(a_key) and not is_integer(b_key) then
      return ranges_comparator(a_val[1], b_val[1])
    end

    return false
  end

local serialize_range =
  function(range)
    return
      { tostring(range:GetStart()), tostring(range:GetLength()) }
  end

local ranges_tree_to_itness
ranges_tree_to_itness =
  function(ranges_tree)
    local result_is = { }
    for key, val in ordered_pass(ranges_tree, ranges_tree_comparator) do
      if is_integer(key) then
        add_to_list(result_is, serialize_range(val))
      end

      if not (is_string(key) and is_table(val)) then goto next end

      add_to_list(result_is, key)
      add_to_list(result_is, ranges_tree_to_itness(val))

      ::next::
    end
    return result_is
  end

-- Export:
return ranges_tree_to_itness

--[[
  2026 #
]]
