-- Function to compare two Lua values

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
]]

local TypeRank_Map =
  {
    ['number'] = 1,
    ['string'] = 2,
    other = 3,
  }

local ComparableTypes_Map =
  {
    ['number'] = true,
    ['string'] = true,
  }

-- Export:
return
  function(a, b)
    local type_a = type(a)
    local rank_a = TypeRank_Map[type_a] or TypeRank_Map.other

    local type_b = type(b)
    local rank_b = TypeRank_Map[type_b] or TypeRank_Map.other

    if (rank_a ~= rank_b) then
      return (rank_a < rank_b)
    end

    if ComparableTypes_Map[type_a] and ComparableTypes_Map[type_b] then
      return (a < b)
    end

    return (tostring(a) < tostring(b))
  end

--[[
  2026-05-23
]]
