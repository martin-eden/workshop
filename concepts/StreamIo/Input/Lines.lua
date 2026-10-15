-- Lines input stream

--[[
  Author: Martin Eden
  Last mod.: 2026-10-15
]]

--[[
  Actually it's wrapper over provided base stream.
]]

local init =
  function(Me, BaseStream)
    Me.BaseStream = BaseStream
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
  local newline = request('!.concepts.Ascii.Chars').newline
  read =
    function(Me)
      -- Naive implementation for first time

      local BaseStream = Me.BaseStream

      local char = BaseStream:Read(1)

      if (char == '') then return false end

      local line = ''

      while true do
        if (char == '') then break end
        if (char == newline) then break end

        line = line .. char

        char = BaseStream:Read(1)
      end

      return true, line
    end
end

local Interface =
  {
    Init = init,
    Read = read,

    -- Internals:
    BaseStream = { },
  }

-- Export:
return Interface

--[[
  2026-07-13
]]
