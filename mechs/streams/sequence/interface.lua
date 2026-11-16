-- Sequence stream interface

--[[
  Author: Martin Eden
  Last mod.: 2026-11-16
]]

--[[
  Storage format

    1 [t] list of values
    2 [i] head position (empty slot)
]]

--[[
  Used in [mechs.parser.parse] as output stream.

  Seeking backward truncates the sequence.

  That's the rollback mechanism: when parser backtracks a failed match,
  restoring position erases records written during the attempt.
]]

local init =
  function(me)
    me[1] = { }
    me[2] = 1
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
      local pos = me[2]
      if (new_position == pos) then return end
      new_position = constrain(new_position, 1, pos)
      for i = pos - 1, new_position, -1 do
        me[1][i] = nil
      end
      me[2] = new_position
    end
end

local write =
  function(me, value)
    me[1][me[2]] = value
    me[2] = me[2] + 1
  end

local get_values =
  function(me)
    return me[1]
  end

-- Export:
return
  {
    init = init,
    get_position = get_position,
    set_position = set_position,
    write = write,
    get_values = get_values,
  }

--[[
  2017 #
  2026 #
  2026-11-15
]]
