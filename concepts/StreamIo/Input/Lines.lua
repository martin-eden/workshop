-- Lines input stream

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  Actually it's wrapper over provided base stream.
]]

local init =
  function(me, base_stream)
    me.base_stream = base_stream
  end

--[[
  Unlike Read() from base streams we have different interface:

  Base Read():

    * Uses one argument (number of bytes to read)
    * If stream is over
      * Returns empty string
    * Returns string with given bytes

  This Read():

    * Uses no arguments (reads one line per call)
    * If stream is over
      * Returns "false"
    * Returns "true" and string with line
]]
local read
do
  local newline = request('!.concepts.ascii.chars').newline
  read =
    function(me)
      -- Naive implementation for first time

      local base_stream = me.base_stream

      local char = base_stream:Read(1)

      if (char == '') then return false end

      local line = ''

      while true do
        if (char == '') then break end
        if (char == newline) then break end

        line = line .. char

        char = base_stream:Read(1)
      end

      return true, line
    end
end

local interface =
  {
    Init = init,
    Read = read,

    -- Internals:
    base_stream = { },
  }

-- Export:
return interface

--[[
  2026-07-13
]]
