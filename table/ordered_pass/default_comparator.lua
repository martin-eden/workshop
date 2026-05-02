-- Default comparator for sorting generic tables

--[[
  Author: Martin Eden
  Last mod.: 2026-05-02
]]

local type_rank_map =
  {
    ['number'] = 1,
    ['string'] = 2,
    other = 3,
  }

local comparable_types_map =
  {
    ['number'] = true,
    ['string'] = true,
  }

local compare =
  function(a, b)
    local a_key = a.key
    local a_key_type = type(a_key)
    local rank_a = type_rank_map[a_key_type] or type_rank_map.other

    local b_key = b.key
    local b_key_type = type(b_key)
    local rank_b = type_rank_map[b_key_type] or type_rank_map.other

    if (rank_a ~= rank_b) then
      return (rank_a < rank_b)
    else
      if comparable_types_map[a_key_type] and comparable_types_map[b_key_type] then
        return (a_key < b_key)
      else
        return (tostring(a_key) < tostring(b_key))
      end
    end
  end

-- Export:
return compare

--[[
  2016-09
  2017-09
]]
