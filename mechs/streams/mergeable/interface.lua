-- Seekable stream interface

--[[
  Author: Martin Eden
  Last mod.: 2026-11-15
]]

local block_read =
  function(me, num_slots)
    local orig_pos = me:get_position()
    local result, num_read = me:read(num_slots)
    if (num_read < num_slots) then
      me:set_position(orig_pos)
      return
    end
    return result
  end

local get_segment =
  function(me, start, len)
    local init_pos = me:get_position()
    me:set_position(start)
    local result = block_read(me, len)
    me:set_position(init_pos)
    return result
  end

local set_relative_position =
  function(me, offset)
    me:set_position(me:get_position() + offset)
  end

local set_next_position =
  function(me)
    me:set_position(me:get_position() + 1)
  end

local get_slot =
  function(me)
    local init_pos = me:get_position()
    local result = block_read(me, 1)
    me:set_position(init_pos)
    return result
  end

return
  {
    -- Obligatory for implementors:
    init = nil,
    get_position = nil,
    set_position = nil,
    read = nil,
    get_length = nil,
    -- Our handy wrappers:
    block_read = block_read,
    get_segment = get_segment,
    set_relative_position = set_relative_position,
    set_next_position = set_next_position,
    get_slot = get_slot,
  }

--[[
  2017
  2026-11-15
]]
