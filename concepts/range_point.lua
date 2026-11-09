-- Point in 1-d range

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  Data storage format

    1 [i] -- minimum value
    2 [i] -- maximum value
    3 [i] -- current value
]]

local get_min_value =
  function(me)
    return me[1]
  end

local set_min_value =
  function(me, val)
    me[1] = val
  end

local get_max_value =
  function(me)
    return me[2]
  end

local set_max_value =
  function(me, val)
    me[2] = val
  end

local get_value
local set_value
do
  local min = math.min
  local max = math.max

  get_value =
    function(me)
      return min(max(me[3], me[1]), me[2])
    end

  set_value =
    function(me, value)
      me[3] = min(max(value, me[1]), me[2])
    end
end

local interface

local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function(min_value, max_value)
      local me = { min_value, max_value, min_value }
      attach_methods(me, interface)
      return me
    end
end

interface =
  {
    create = create,

    get_min_value = get_min_value,
    set_min_value = set_min_value,

    get_max_value = get_max_value,
    set_max_value = set_max_value,

    get_value = get_value,
    set_value = set_value,
  }

-- Export:
return interface

--[[
  2026 # # # #
  2026-11-09
]]
