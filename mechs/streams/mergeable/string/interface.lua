-- String stream interface

--[[
  Author: Martin Eden
  Last mod.: 2026-11-15
]]

--[[
  Storage format

    1 [s] string
    2 [i] position
]]

local init =
  function(me, str)
    assert_string(str)
    me[1] = str
    me[2] = 1
  end

local get_length =
  function(me)
    return #me[1]
  end

local get_position =
  function(me)
    return me[2]
  end

local set_position
do
  local constrain = request('!.number.constrain')
  set_position =
    function(me, new_position)
      me[2] = constrain(new_position, 1, #me[1] + 1)
    end
end

local str_sub = string.sub

local read =
  function(me, num_slots)
    local pos = me[2]
    local result = str_sub(me[1], pos, pos + num_slots - 1)
    me[2] = pos + #result
    return result, #result
  end

local match_string =
  function(me, str)
    local pos = me[2]
    local segment = str_sub(me[1], pos, pos + #str - 1)
    if (segment == str) then
      me[2] = pos + #str
      return true
    end
  end

local match_regexp
do
  local str_find = string.find
  match_regexp =
    function(me, pattern)
      local start, finish, capture = str_find(me[1], pattern, me[2])
      if start then
        set_position(me, finish + 1)
        capture = capture or str_sub(me[1], start, finish)
        return capture
      end
    end
end

local overrides =
  {
    -- Core:
    init = init,
    get_length = get_length,
    get_position = get_position,
    set_position = set_position,
    read = read,
    -- Extensions:
    match_string = match_string,
    match_regexp = match_regexp,
  }

local base_interface = request('^.interface')
local force_merge = request('!.table.merge_and_patch')

local interface = new(base_interface)
force_merge(interface, overrides)

-- Export:
return interface

--[[
  2017 #
  2026 #
  2026-11-15
]]
