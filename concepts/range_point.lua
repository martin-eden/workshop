-- Point in 1-d range

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  Data storage format

    1 [i] -- current value
    2 [i] -- minimum value
    3 [i] -- maximum value
]]

local get_min_value =
  function(me)
    return me[2]
  end

local set_min_value =
  function(me, val)
    me[2] = val
  end

local get_max_value =
  function(me)
    return me[3]
  end

local set_max_value =
  function(me, val)
    me[3] = val
  end

local get_value
local set_value
do
  local min = math.min
  local max = math.max

  get_value =
    function(me)
      return min(max(me[1], me[2]), me[3])
    end

  set_value =
    function(me, value)
      me[1] = min(max(value, me[2]), me[3])
    end
end

local interface

local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function()
      local me = { 0, 0, 1 }
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
